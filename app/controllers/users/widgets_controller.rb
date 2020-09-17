# frozen_string_literal: true

class Users::WidgetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_access_token, :set_user

  def index
    @widgets = Users::WidgetsListService.call(@user.id, params[:term])
  end

  def new
    @widget = Widget.new
  end

  def create
    @widget = Widget.new(widget_params)

    if @widget.save(@access_token)
      redirect_to user_widgets_path("me"), notice: "Widget created successfully."
    else
      render :new
    end
  end

  private

    def set_access_token
      @access_token = GetAccessTokenService.call(current_user)
    end

    def set_user
      @user = Registration.find(@access_token, params[:user_id])
    end

    def widget_params
      params.require(:widget).permit(:name, :description, :kind)
    end
end
