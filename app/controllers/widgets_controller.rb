# frozen_string_literal: true

class WidgetsController < ApplicationController
  def index
    @widgets = VisibleWidgetsListService.call(params[:term])
  end
end
