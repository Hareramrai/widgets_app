# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    @session = Session.new
  end

  def create
    @session = Session.new(session_params)

    if @session.save
      user = Authentication::UpdateTokenService.call(@session.username,
                                                     @session.api_response_data)
      session[:user_id] = user.id

      render :create, notice: "Signin successfully."
    else
      render :new
    end
  end

  def destroy
    access_token = GetAccessTokenService.call(current_user)
    response = Authentication::RevokeAccessService.call(access_token)

    session.delete :user_id

    if response[:status]
      redirect_to :root, notice: "Logged Out Successfully"
    else
      redirect_to :root, warning: "Something went wrong!"
    end
  end

  private

    def session_params
      params.require(:session).permit(:username, :password)
    end
end
