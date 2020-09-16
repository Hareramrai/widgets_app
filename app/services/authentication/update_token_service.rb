# frozen_string_literal: true

class Authentication::UpdateTokenService < ApplicationService
  def initialize(email, api_response_data)
    @email = email
    @data = api_response_data
  end

  def call
    user = User.where(email: email).first_or_initialize
    user.update(user_attributes)
    user
  end

  private

    attr_reader :email, :data

    def user_attributes
      {
        access_token: token_params[:access_token],
        refresh_token: token_params[:refresh_token],
        expires_in: token_params[:expires_in],
        token_created_at: token_params[:created_at],
      }
    end

    def token_params
      data[:token]
    end
end
