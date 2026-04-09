require "rails_helper"

RSpec.describe "Repositories", type: :request do
  describe "GET /repositories" do
    it "returns a successful HTML response with the empty state" do
      get "/repositories"

      expect(response).to have_http_status(:ok)
      expect(response.media_type).to eq("text/html")
      expect(response.body).to include("No repositories yet")
    end

    it "renders persisted repository data including default_base_ref" do
      Repository.create!(
        provider: "github",
        namespace_path: "acme/platform",
        name: "loki",
        default_base_ref: "main"
      )
      Repository.create!(
        provider: "gitlab",
        namespace_path: "acme/tools",
        name: "atlas",
        default_base_ref: "develop"
      )

      get "/repositories"

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("github", "acme/platform", "loki", "main")
      expect(response.body).to include("gitlab", "acme/tools", "atlas", "develop")
    end

    it "routes to repositories#index" do
      route = Rails.application.routes.recognize_path("/repositories", method: :get)

      expect(route).to include(controller: "repositories", action: "index")
    end

    it "does not add other repository routes" do
      expect {
        Rails.application.routes.recognize_path("/repositories/new", method: :get)
      }.to raise_error(ActionController::RoutingError)

      expect {
        Rails.application.routes.recognize_path("/repositories/1", method: :get)
      }.to raise_error(ActionController::RoutingError)
    end
  end
end
