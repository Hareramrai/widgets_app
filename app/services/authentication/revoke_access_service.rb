# frozen_string_literal: true

class Authentication::RevokeAccessService < ApplicationService
  def initialize(token)
    @token = token
  end

  def call
    Widgets::Client.post(token, "/oauth/revoke", { token: token })
  end

  private

    attr_reader :token
end
