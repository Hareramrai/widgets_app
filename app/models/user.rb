# frozen_string_literal: true

class User < ApplicationRecord
  def username
    name.presence || email[/[^@]+/]
  end

  def name
    "#{first_name} #{last_name}"
  end
end
