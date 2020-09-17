# frozen_string_literal: true

class VisibleWidgetsListService < ApplicationService
  API_RESOURCE = "/api/v1/widgets/visible"

  def initialize(term = nil)
    @term = term
  end

  def call
    response = Widgets::OauthClient.get(API_RESOURCE, api_params)
    widgets_from_response(response)
  end

  private

    attr_reader :term

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
