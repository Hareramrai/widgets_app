# frozen_string_literal: true

class Widgets::Client
  API_ENDPOINT = Rails.application.secrets.client_url

  class << self
    def post(token, resource, params = {})
      request(token, :post, resource, params)
    end

    def client(token)
      RestClient::Resource
        .new API_ENDPOINT,
             verify_ssl: false, headers: headers(token)
    end

    def headers(token)
      { accept: :json, Authorization: "Bearer #{token}" }
    end

    def request(token, http_method, resource, body = {})
      response = client(token)[resource].public_send http_method, body
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
