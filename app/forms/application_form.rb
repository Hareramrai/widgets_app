# frozen_string_literal: true

class ApplicationForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attr_accessor :api_response_data

  private

    def response_and_error(response)
      self.api_response_data = response.dig(:body, :data)
      unless response[:status]
        errors.add(:widgets_api_error, response.dig(:body, :message))
      end

      response[:status]
    end
end
