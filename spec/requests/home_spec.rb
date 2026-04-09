require "rails_helper"

RSpec.describe "Home", type: :request do
  describe "GET /" do
    it "returns a successful HTML response" do
      get root_path

      expect(response).to have_http_status(:ok)
      expect(response.media_type).to eq("text/html")
    end
  end
end
