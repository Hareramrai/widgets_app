# frozen_string_literal: true

class UpdateUserService < ApplicationService
  def initialize(api_response_data)
    @data = api_response_data
  end

  def call
    user = User.where(email: user_attributes[:email]).first_or_initialize
    user.update(user_attributes)
    user
  end

  private

    attr_reader :data

    def user_attributes
      user_profile = {
        first_name: user_params[:first_name],
        last_name: user_params[:last_name],
        email: user_params[:email],
        active: user_params[:active],
        widget_user_id: user_params[:id],
        image_url: user_params.dig(:images, :small_url),
      }

      user_token_fields(user_profile)
    end

    def user_params
      data[:user]
    end

    def token_params
      data[:token]
    end

    def user_token_fields(user_profile)
      return user_profile if token_params.blank?

      user_profile.merge!(
        access_token: token_params[:access_token],
        refresh_token: token_params[:refresh_token],
        expires_in: token_params[:expires_in],
        token_created_at: token_params[:created_at]
      )
    end
end
