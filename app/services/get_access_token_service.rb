# frozen_string_literal: true

class GetAccessTokenService < ApplicationService
  CLIENT_ID = Rails.application.secrets.client_id
  CLIENT_SECRET = Rails.application.secrets.client_secret

  delegate :access_token, :expires_in, :refresh_token, :token_created_at, to: :user

  def initialize(user)
    @user = user
  end

  def call
    return access_token unless token_expired?

    refresh_token!
    access_token
  end

  private

    attr_reader :user

    def token_expired?
      expires_at = token_created_at + expires_in
      expires_at < Time.now.to_i
    end

    def refresh_token!
      params = {
        grant_type: "refresh_token",
        refresh_token: refresh_token,
        client_id: CLIENT_ID,
        client_secret: CLIENT_SECRET,
      }

      @response = Widgets::Client.post(access_token, "/oauth/token", params)

      update_token
    end

    def update_token
      user.update(
        access_token: user_token[:access_token],
        expires_in: user_token[:expires_in],
        refresh_token: user_token[:refresh_token],
        token_created_at: user_token[:created_at]
      )
    end

    def user_token
      @response.dig(:body, :data, :token)
    end
end
