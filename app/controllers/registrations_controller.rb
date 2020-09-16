# frozen_string_literal: true

class RegistrationsController < ApplicationController
  def new
    @registration = Registration.new
  end

  def create
    @registration = Registration.new(registration_params)

    if @registration.save
      user = Authentication::SignupUserService.call(@registration.api_response_data)
      session[:user_id] = user.id

      render :create, notice: "Thank you, Registration was successful."
    else
      render :new
    end
  end

  private

    def registration_params
      params.require(:registration).permit(:first_name, :last_name, :email, :password,
                                           :image_url)
    end
end
