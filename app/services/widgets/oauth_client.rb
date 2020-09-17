# frozen_string_literal: true

class Widgets::OauthClient
  API_ENDPOINT = Rails.application.secrets.client_url
  CLIENT_ID = Rails.application.secrets.client_id
  CLIENT_SECRET = Rails.application.secrets.client_secret

  class << self
    def get(resource, params = {})
      request(:get, "#{resource}?#{merge_credentials(params).to_query}")
    end

    def post(resource, params = {})
      request(:post, resource, merge_credentials(params))
    end

    def client(open_timeout = 120)
      @client ||= RestClient::Resource
                  .new API_ENDPOINT,
                       open_timeout: open_timeout,
                       verify_ssl: false, headers: { accept: :json }
    end

    def merge_credentials(params)
      params.merge(client_id: CLIENT_ID, client_secret: CLIENT_SECRET)
    end

    def request(http_method, resource, body = {})
      response = client[resource].public_send http_method, body
      { status: true, body: response_body(response) }
    rescue RestClient::Unauthorized,
           RestClient::Forbidden,
           RestClient::BadRequest,
           RestClient::UnprocessableEntity => e

      { status: false, body: response_body(e.response), status_code: e.response.code }
    end

    def response_body(response)
      Oj.load(response&.body, symbol_keys: true)
    end
  end
end
