# frozen_string_literal: true

class PasswordsController < ApplicationController
  before_action :set_access_token, only: [:create]
  def new
    @password = Password.new
  end

  def create
    @password = Password.new(password_params)

    if @password.save_using_token(@access_token)
      Authentication::UpdateTokenService.call(current_user.email,
                                              @password.api_response_data)
      render
    else
      render :new
    end
  end

  private

    def password_params
      params.require(:password).permit(:current_password, :new_password)
    end

    def set_access_token
      @access_token = GetAccessTokenService.call(current_user)
    end
end
