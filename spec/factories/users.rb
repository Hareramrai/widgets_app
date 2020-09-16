# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { "MyString" }
    last_name { "MyString" }
    email { "MyString" }
    image_url { "MyString" }
    active { false }
    access_token { "MyString" }
    expires_in { 1 }
    refresh_token { "MyString" }
    widget_user_id { 1 }
  end
end
