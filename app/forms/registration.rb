# frozen_string_literal: true

class Registration
  API_RESOURCE = "/api/v1/users"

  include ActiveModel::Model
  include ActiveModel::Attributes

  attr_accessor :api_response_data

  attribute :email
  attribute :password
  attribute :first_name
  attribute :last_name
  attribute :image_url

  validates :email, presence: true, email: true
  validates :password, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :image_url, presence: true

  def save
    return false unless valid?

    response = Widgets::OauthClient.post(API_RESOURCE, user: attributes)

    self.api_response_data = response.dig(:body, :data)

    errors.add(:widgets_api_error, response.dig(:body, :message)) unless response[:status]

    response[:status]
  end
end
