module Spec
  module Support
    module ApiHelpers
      def json
        JSON.parse(response.body)
      end

      def login_with_api(user)
        post '/login', params: {
          user: {
            email: user.email,
            password: user.password
          }
        }
      end

      def authorization_header
        { 'Authorization': response.headers['Authorization'] }
      end
    end
  end
end
