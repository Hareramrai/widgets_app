# frozen_string_literal: true

class Authentication::SigninUserService < ApplicationService
  def initialize(session)
    @session = session
  end

  def call
    user = User.where(email: session.username).first_or_initialize(user_attributes)
    user.save!
    user
  end

  private

    attr_reader :session

    def user_attributes
      {
        access_token: token_params[:access_token],
        refresh_token: token_params[:refresh_token],
        expires_in: token_params[:expires_in],
      }
    end

    def token_params
      session.api_response_data[:token]
    end
end
