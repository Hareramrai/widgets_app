# frozen_string_literal: true

class Widget < ApplicationForm
  API_RESOURCE = "/api/v1/widgets"

  attribute :name
  attribute :description
  attribute :kind

  validates :name, :description, presence: true

  def save(access_token)
    return false unless valid?

    response = Widgets::Client.post(access_token, API_RESOURCE, widget: attributes)

    response_and_error(response)
  end
end
