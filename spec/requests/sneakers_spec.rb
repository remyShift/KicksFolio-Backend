require 'rails_helper'

RSpec.describe "Sneakers", type: :request do
  include ActionDispatch::TestProcess

  let(:user) { create(:user) }
  let(:token) { JWT.encode({ sub: user.id, exp: 24.hours.from_now.to_i }, ENV["JWT_SECRET"], "HS256") }
  let(:headers) { { "Authorization" => "Bearer #{token}" } }
  let!(:collection) { create(:collection, user: user) }
  let(:file) do
    fixture_file_upload(
      Rails.root.join('spec/fixtures/files/sneaker.jpg'),
      'image/jpeg'
    )
  end

  describe "POST /create" do
    it "creates a new sneaker in the users collection" do
      form_data = {
        'sneaker[model]' => "Air Jordan 1",
        'sneaker[brand]' => "Nike",
        'sneaker[size]' => "9.5",
        'sneaker[condition]' => "10",
        'sneaker[status]' => "rocking",
        'sneaker[images][]' => file
      }

      post "/api/v1/users/#{user.id}/collection/sneakers",
        params: form_data,
        headers: headers

      expect(response).to have_http_status(:created)
    end

    it "creates a new sneaker with photos in the users collection" do
      form_data = {
        'sneaker[model]' => "Air Jordan 1",
        'sneaker[brand]' => "Nike",
        'sneaker[size]' => "9.5",
        'sneaker[condition]' => "10",
        'sneaker[status]' => "rocking",
        'sneaker[images][]' => file
      }

      post "/api/v1/users/#{user.id}/collection/sneakers",
        params: form_data,
        headers: headers

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)["sneaker"]["images"]).to be_present
    end

    it "returns an error if the sneaker has no images" do
      post "/api/v1/users/#{user.id}/collection/sneakers",
        params: {
          sneaker: {
            model: "Air Jordan 1",
            brand: "Nike",
            size: 9.5,
            condition: 10
          }
        },
        headers: headers

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)["errors"]).to include("Images can't be blank")
    end
  end

  describe "GET /index" do
    it "returns all sneakers in the users collection" do
      get "/api/v1/users/#{user.id}/collection/sneakers", headers: headers
      expect(response).to have_http_status(:ok)
      response_body = JSON.parse(response.body)
      expect(response_body["sneakers"].count).to eq(collection.sneakers.count)
    end
  end

  describe "DELETE /destroy" do
    it "deletes a sneaker from the users collection" do
      sneaker = create(:sneaker, collection: collection, images: [ file ])
      delete "/api/v1/users/#{user.id}/collection/sneakers/#{sneaker.id}", headers: headers
      expect(response).to have_http_status(:no_content)
    end
  end

  describe "PATCH /api/v1/users/:id/collection/sneakers/:id" do
    it "updates a sneaker" do
      sneaker = create(:sneaker, collection: collection, images: [ file ])
      patch "/api/v1/users/#{user.id}/collection/sneakers/#{sneaker.id}",
        params: {
          sneaker: {
            condition: 9
          }
        },
        headers: headers

      expect(response).to have_http_status(:ok)
      expect(sneaker.reload.condition).to eq(9)
    end
  end
end
