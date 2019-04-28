require "faraday"
require 'multi_json'

module Codeship
  ENDPOINT = "https://api.codeship.com"

  def self.call
    build_data = []
    organizations.each do |organization|
      projects(organization["uuid"]).each do |project|
        build_data << builds(organization["uuid"], project["uuid"])
      end
    end
    build_data.flatten!
  end

  def self.organizations
    @organizations ||= MultiJson.load(API.auth.body).dig("organizations")
  end

  def self.projects(organization_uuid)
    @projects ||= MultiJson.load(API.get_projects(organization_uuid).body).dig("projects")
  end

  def self.builds(organization_uuid, project_uuid)
    MultiJson.load(API.get_builds(organization_uuid, project_uuid).body).dig("builds")
  end

  class API
    class << self
      def connection
        @connection ||= Faraday.new(
          url: ENDPOINT,
          headers: {
            "Content-Type" => 'application/json',
            "Accept" => 'application/json'
          }
        )
      end

      def auth
        conn ||= connection
        conn.basic_auth(ENV["USERNAME"], ENV["PASSWORD"])
        @auth ||= conn.post("v2/auth")
      end

      def get_projects(organization_uuid)
        conn = connection
        conn.authorization :bearer, access_token
        @projects ||= conn.get("v2/organizations/#{organization_uuid}/projects")
      end

      def get_builds(organization_uuid, project_uuid)
        conn = connection
        conn.authorization :bearer, access_token
        conn.get("v2/organizations/#{organization_uuid}/projects/#{project_uuid}/builds")
      end

      def access_token
        @acces_token ||= MultiJson.load(auth.body).dig("access_token")
      end
    end
  end
end
