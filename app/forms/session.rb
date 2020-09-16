# frozen_string_literal: true

class Session
  API_RESOURCE = "/oauth/token"

  include ActiveModel::Model
  include ActiveModel::Attributes

  attr_accessor :api_response_data

  attribute :username
  attribute :password
  attribute :grant_type

  validates :username, presence: true, email: true
  validates :password, presence: true

  def save
    return false unless valid?

    self.grant_type = "password"

    response = Widgets::OauthClient.post(API_RESOURCE, attributes)

    self.api_response_data = response.dig(:body, :data)

    errors.add(:widgets_api_error, response.dig(:body, :message)) unless response[:status]

    response[:status]
  end
end
