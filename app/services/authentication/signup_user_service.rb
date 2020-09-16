# frozen_string_literal: true

class Authentication::SignupUserService < ApplicationService
  def initialize(api_response_data)
    @data = api_response_data
  end

  def call
    User.create!(user_attributes)
  end

  private

    attr_reader :data

    def user_attributes
      {
        first_name: user_params[:first_name],
        last_name: user_params[:last_name],
        email: user_params[:email],
        active: user_params[:active],
        widget_user_id: user_params[:id],
        image_url: user_params.dig(:images, :small_url),
        access_token: token_params[:access_token],
        refresh_token: token_params[:refresh_token],
        expires_in: token_params[:expires_in],
      }
    end

    def user_params
      data[:user]
    end

    def token_params
      data[:token]
    end
end
