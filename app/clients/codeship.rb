require 'multi_json'

module Codeship
  require_relative "codeship/api"
  ENDPOINT = "https://api.codeship.com"

  def self.call(page_number: 1)
    build_data = []
    organizations.each do |organization|
      projects(organization["uuid"]).each do |project|
        build_data << builds(organization["uuid"], project["uuid"], page_number)
          .map { |build| build.merge({ "project_name": project["name"]}) }
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

  def self.builds(organization_uuid, project_uuid, page_number)
    MultiJson.load(API.get_builds(organization_uuid, project_uuid, page_number).body).dig("builds")
  end
end
