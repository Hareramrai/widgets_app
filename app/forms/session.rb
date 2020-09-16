# frozen_string_literal: true

class Session < ApplicationForm
  API_RESOURCE = "/oauth/token"

  attribute :username
  attribute :password
  attribute :grant_type

  validates :username, presence: true, email: true
  validates :password, presence: true

  def save
    return false unless valid?

    self.grant_type = "password"
    response = Widgets::OauthClient.post(API_RESOURCE, attributes)

    response_and_error(response)
  end
end
