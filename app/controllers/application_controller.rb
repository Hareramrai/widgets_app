# frozen_string_literal: true

class ApplicationController < ActionController::Base
  private

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def authenticate_user!
      redirect_to root_url, alert: "Not authorized" if current_user.nil?
    end

    helper_method :current_user
end
