module DropboxApi::Endpoints
  class Rpc < DropboxApi::Endpoints::Base
    def initialize(builder)
      @connection = builder.build("https://api.dropboxapi.com") do |c|
        c.response :decode_result
      end
    end

    def build_request(params)
      body = JSON.dump(params)
      headers = {
        'content-type' => 'application/json'
      }

      return body, headers
    end
  end
end
