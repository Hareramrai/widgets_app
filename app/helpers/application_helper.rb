# frozen_string_literal: true

module ApplicationHelper
  # TODO: implement me
  def user_signed_in?
    current_user.present?
  end
end
