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

  describe "DELETE /api/v1/logout" do
    let(:user) { create(:user) }
    let(:token) { JWT.encode({ sub: user.id, exp: 24.hours.from_now.to_i }, ENV["JWT_SECRET"], "HS256") }

    it "logs out successfully with valid token" do
      delete "/api/v1/logout", headers: { "Authorization" => "Bearer #{token}" }
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response["message"]).to eq("Successfully logged out")
    end

    it "returns unauthorized without token" do
      delete "/api/v1/logout"
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns unauthorized with invalid token" do
      delete "/api/v1/logout", headers: { "Authorization" => "Bearer invalid_token" }
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns unauthorized with expired token" do
      expired_token = JWT.encode(
        { sub: user.id, exp: 1.day.ago.to_i },
        ENV["JWT_SECRET"],
        "HS256"
      )
      delete "/api/v1/logout", headers: { "Authorization" => "Bearer #{expired_token}" }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
