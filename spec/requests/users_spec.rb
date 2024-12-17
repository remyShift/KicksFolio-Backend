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

  describe "POST api/v1/login" do
    let(:user) { create(:user, email: "test@example.com", password: "Password123") }
  
    it "logs in a user" do
      post "/api/v1/login", params: { 
        authentication: { 
          email: user.email, 
          password: "Password123", 
          remember_me: false 
        } 
      }
      expect(response).to have_http_status(:ok)
    end
  end

  describe "DELETE api/v1/logout" do
    let(:user) { create(:user, email: "test@example.com", password: "Password123") }
    let(:token) { JWT.encode({ sub: user.id, exp: 24.hours.from_now.to_i }, ENV["JWT_SECRET"], "HS256") }
  
    it "logs out a user" do
      delete "/api/v1/logout", headers: { "Authorization" => "Bearer #{token}" }
      expect(response).to have_http_status(:ok)
    end
  end

  describe "DELETE api/v1/users/:id" do
    let!(:user) { create(:user, email: "test@example.com", password: "Password123") }
    let!(:token) { JWT.encode({ sub: user.id, exp: 24.hours.from_now.to_i }, ENV["JWT_SECRET"], "HS256") }

    it "deletes a user" do
      delete "/api/v1/users/#{user.id}", headers: { "Authorization" => "Bearer #{token}" }
      expect(response).to have_http_status(:no_content)
    end

    it "returns an error if the user is not found" do
      delete "/api/v1/users/9999", headers: { "Authorization" => "Bearer #{token}" }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "PATCH api/v1/users/:id" do
    let!(:user) { create(:user, email: "test@example.com", password: "Password123") }
    let!(:token) { JWT.encode({ sub: user.id, exp: 24.hours.from_now.to_i }, ENV["JWT_SECRET"], "HS256") }

    it "updates a user" do
      patch "/api/v1/users/#{user.id}", params: { 
        user: { 
          email: "test2@example.com", 
          password: "Password1234", 
          username: "testuser2", 
          first_name: "Jane", 
          last_name: "Doe", 
          sneaker_size: 11, 
          gender: "female" 
        } 
      }, headers: { "Authorization" => "Bearer #{token}" }
      expect(response).to have_http_status(:ok)
      expect(user.reload.email).to eq("test2@example.com")
      expect(user.reload.username).to eq("testuser2")
      expect(user.reload.first_name).to eq("Jane")
      expect(user.reload.last_name).to eq("Doe")
      expect(user.reload.sneaker_size).to eq(11)
      expect(user.reload.gender).to eq("female")
    end
  end
end

