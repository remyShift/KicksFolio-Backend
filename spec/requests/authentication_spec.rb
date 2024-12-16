require "rails_helper"

RSpec.describe "Authentication", type: :request do
  describe "POST /auth" do
    it "should create a user with valid params" do
      post "/auth", params: {
        email: "test@test123.com",
        password: "Password123",
        pseudo: "test",
        first_name: "test",
        last_name: "test",
        sneaker_size: "10",
        gender: "male",
        confirm_success_url: ""
      }
      expect(response).to have_http_status(:ok)
    end

    it "should not create a user with invalid params and return an error" do
      post "/auth", params: {
        email: "test@test123.com",
        password: "Password123",
        pseudo: "test",
        first_name: "test",
        last_name: "test",
        sneaker_size: "10.9",
        gender: "male",
        confirm_success_url: ""
      }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "POST /auth/sign_in" do
    it "should sign in a user" do
      post "/auth", params: {
        email: "test@test123.com",
        password: "Password123",
        pseudo: "test",
        first_name: "test",
        last_name: "test",
        sneaker_size: "10",
        gender: "male",
        confirm_success_url: ""
      }
      expect(response).to have_http_status(:ok)

      post "/auth/sign_in", params: { email: "test@test123.com", password: "Password123" }
      puts response.body
      expect(response).to have_http_status(:ok)
    end
  end
end
