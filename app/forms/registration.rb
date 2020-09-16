# frozen_string_literal: true

class Registration < ApplicationForm
  API_CREATE_RESOURCE = "/api/v1/users"
  API_RESOURCE_ME = "/api/v1/users/me"

  attribute :email
  attribute :password
  attribute :first_name
  attribute :last_name
  attribute :image_url

  validates :email, presence: true, email: true, allow_nil: true
  validates :password, presence: true, allow_nil: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :image_url, presence: true

  def self.find_me(token)
    response = Widgets::Client.get(token, API_RESOURCE_ME)
    user = response.dig(:body, :data, :user)

    new(first_name: user[:first_name], last_name: user[:last_name],
        image_url: user.dig(:images, :original_url))
  end

  def save
    return false unless valid?

    response = Widgets::OauthClient.post(API_CREATE_RESOURCE, user: attributes)
    response_and_error(response)
  end

  def update_using_token(token)
    return false unless valid?

    response = Widgets::Client.put(token, API_RESOURCE_ME, user: attributes.compact)
    response_and_error(response)
  end
end
