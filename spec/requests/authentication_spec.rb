require 'rails_helper'

RSpec.describe "Authentications", type: :request do
  describe "POST /api/v1/users" do
    it "Creates a user" do
      post "/api/v1/users", params: {     
        user: {
          email: "toto@example.com",
          password: "Password123",
          username: "totouser",
          first_name: "John",
          last_name: "Doe",
          sneaker_size: 10,
          gender: "male"
        }
      }
      expect(response).to have_http_status(:created)
    end
  end

  describe "POST /api/v1/login" do
    let(:user) { create(:user) }

    it "Logs in a user with valid credentials" do
      post "/api/v1/login", params: {
        authentication: {
          email: user.email,
          password: user.password
        }
      }
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response).to include("token", "user")
      expect(json_response["user"]).not_to include("password_digest")
    end

    it "returns unauthorized for invalid credentials" do
      post "/api/v1/login", params: {
        authentication: {
          email: "toto@example.com",
          password: "WrongPassword"
        }
      }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
