# frozen_string_literal: true

class Users::WidgetsListService < ApplicationService
  API_RESOURCE = "/api/v1/users/:id/widgets"

  def initialize(user_id, term)
    @user_id = user_id.to_s
    @term = term
  end

  def call
    response = Widgets::OauthClient.get(api_resource, api_params)
    widgets_from_response(response)
  end

  private

    attr_reader :user_id, :term

    def api_resource
      API_RESOURCE.gsub(/:id/, user_id)
    end

    def api_params
      { term: term }.compact
    end

    def widgets_from_response(response)
      if response[:status]
        response.dig(:body, :data, :widgets)
      else
        []
      end
    end
end
