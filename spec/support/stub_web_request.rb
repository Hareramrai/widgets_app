# frozen_string_literal: true

def stub_get_request(resource, token, params = {}, returns = {}, status = 200)
  stub_web_request(:get, resource, token, params, returns.to_json, status)
end

def stub_web_request(method, resource, token, params, returns, status)
  stub_request(method, "https://showoff-rails-react-production.herokuapp.com/#{resource}")
    .with(
      headers: {
        "Accept" => "application/json",
        "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
        "Authorization" => "Bearer #{token}",
        "Host" => "showoff-rails-react-production.herokuapp.com",
        "User-Agent" => "rest-client/2.1.0 (darwin18.7.0 x86_64) ruby/2.7.1p83",
      }
    ).to_return(status: status, body: returns, headers: { "Content-Type" => "application/json" })
end

def stub_oauth_post_request(resource, params = {}, returns = {}, status = 200)
  params.merge!(client_id: Rails.application.secrets.client_id, client_secret: Rails.application.secrets.client_secret)

  stub_oauth_request(:post, resource, params, returns.to_json, status)
end

def stub_oauth_request(method, resource, params, returns, status)
  stub_request(method, "#{Rails.application.secrets.client_url}#{resource}").with(
    body: params,
    headers: {
      "Accept" => "application/json",
      "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
      "Content-Length" => "298",
      "Content-Type" => "application/x-www-form-urlencoded",
      "Host" => "showoff-rails-react-production.herokuapp.com",
      "User-Agent" => "rest-client/2.1.0 (darwin18.7.0 x86_64) ruby/2.7.1p83",
    }
  ).to_return(status: status, body: returns, headers: { "Content-Type" => "application/json" })
end
