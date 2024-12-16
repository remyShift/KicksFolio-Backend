require "rails_helper"

RSpec.describe "Authentication", type: :request do
  let(:user) {
    User.create!(
      email: 'test123@example.com',
      password: 'Password123',
      password_confirmation: 'Password123',
      pseudo: 'test213',
      first_name: 'test',
      last_name: 'test',
      sneaker_size: '10',
      gender: 'male'
    )
  }

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
      expect(response).to have_http_status(:success)
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

  describe 'POST /auth/sign_in' do
    it 'logs in the user with valid credentials' do
      post '/auth/sign_in', params: {
        email: user.email,
        password: 'Password123'
      }, headers: {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }

      puts response.body
      expect(response).to have_http_status(:success)
      expect(response.headers).to include('access-token', 'client', 'uid')
    end
  end
end
