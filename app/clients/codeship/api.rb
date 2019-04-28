module Codeship
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
