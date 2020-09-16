# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    @session = Session.new
  end

  def create
    @session = Session.new(session_params)

    if @session.save
      user = Authentication::SigninUserService.call(@session)
      session[:user_id] = user.id

      render :create, notice: "Signin successfully."
    else
      render :new
    end
  end

  def destroy
    response = Authentication::RevokeAccessService.call(current_user.access_token)
    if response[:status]
      session.delete :user_id
      redirect_to :root, notice: "Logged Out Successfully"
    else
      redirect_to :root, error: "Something went wrong!"
    end
  end

  private

    def session_params
      params.require(:session).permit(:username, :password)
    end
end
