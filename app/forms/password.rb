# frozen_string_literal: true

class Password < ApplicationForm
  API_RESOURCE = "/api/v1/users/me/password"

  attribute :current_password
  attribute :new_password

  validates :current_password, :new_password, presence: true, length: 8..20

  def save_using_token(token)
    return false unless valid?

    response = Widgets::Client.post(token, API_RESOURCE, user: attributes)

    response_and_error(response)
  end
end
