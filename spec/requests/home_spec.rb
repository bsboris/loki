require "rails_helper"

RSpec.describe "Home", type: :request do
  describe "GET /" do
    it "returns a successful HTML response" do
      get root_path

      expect(response).to have_http_status(:ok)
      expect(response.media_type).to eq("text/html")
      document = Nokogiri::HTML5(response.body)

      expect(document.css("h1").map(&:text)).to eq(["Loki"])
      expect(response.body).to include("Git-native translation workspace system for YAML-based i18n.")
      expect(response.body).to include("Styling system")
      expect(response.body).to include("daisyUI primitives are available for shared UI elements.")
      expect(document.at_css(".card")).to be_present
    end
  end
end
