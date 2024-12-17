require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST /api/v1/users" do
    let(:user_params) { 
      { 
        user: { 
          email: "test@example.com", 
          password: "Password123", 
          username: "testuser", 
          first_name: "John", 
          last_name: "Doe", 
          sneaker_size: 10, 
          gender: "male" 
        } 
      } 
    }

    it "creates a new user" do
      post "/api/v1/users", params: user_params
      expect(response).to have_http_status(:created)
    end
  end
end

