# frozen_string_literal: true

require "rails_helper"

RSpec.describe Registration, type: :model do
  let(:token) { "mytoken" }
  let(:user_id) { 123 }
  let(:first_name) { "John" }
  let(:last_name) { "Smith" }
  let(:original_url) { "https://google.com" }
  let(:email) { "jsmith@example.com" }
  let(:password) { "password123" }

  let(:returns) do
    {
      data: {
        user: {
          id: user_id,
          first_name: first_name,
          last_name: last_name,
          images: { original_url: original_url },
        },
      },
    }
  end

  let(:new_user) do
    Registration.new(first_name: first_name, last_name: last_name,
                     email: email, password: password, image_url: original_url)
  end

  describe "validations" do
    it { should validate_presence_of(:email).allow_nil }
    it { should validate_presence_of(:password).allow_nil }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:image_url) }
  end

  describe ".find" do
    context "when user exists in external service" do
      it "return an instance of Registration with values" do
        stub_get_request("/api/v1/users/#{user_id}", token, {}, returns)

        user = described_class.find(token, user_id)

        expect(user).to be_instance_of(Registration)

        expect(user.first_name).to eq(first_name)
        expect(user.last_name).to eq(last_name)
        expect(user.image_url).to eq(original_url)
      end
    end
  end

  describe "#save" do
    it "saves the new user and returns response of new user" do
      stub_oauth_post_request("/api/v1/users", { user: new_user.attributes.compact }, { data: { user: { id: user_id } } })

      new_user.save

      expect(new_user.api_response_data).to be_present
      expect(new_user.api_response_data.dig(:user, :id)).to be_present
    end
  end
end
