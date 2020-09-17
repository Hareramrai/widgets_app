# frozen_string_literal: true

class RegistrationsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]

  before_action :set_access_token, only: [:edit, :update]
  before_action :set_registration, only: [:edit]

  def new
    @registration = Registration.new
  end

  def create
    @registration = Registration.new(registration_params)

    if @registration.save
      user = UpdateUserService.call(@registration.api_response_data)
      session[:user_id] = user.id

      render :create, notice: "Thank you, Registration was successful."
    else
      render :new
    end
  end

  def edit
  end

  def update
    @registration = Registration.new(registration_params)

    if @registration.update_using_token(@access_token)
      UpdateUserService.call(@registration.api_response_data)

      current_user.reload
      render
    else
      render :edit
    end
  end

  private

    def registration_params
      params.require(:registration).permit(:first_name, :last_name, :email, :password,
                                           :image_url)
    end

    def set_access_token
      @access_token = GetAccessTokenService.call(current_user)
    end

    def set_registration
      @registration = Registration.find_me(@access_token)
    end
end
