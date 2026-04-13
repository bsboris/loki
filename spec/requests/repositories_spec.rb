require "rails_helper"

RSpec.describe "Repositories", type: :request do
  describe "GET /repositories" do
    it "returns a successful HTML response with the empty state" do
      get "/repositories"

      expect(response).to have_http_status(:ok)
      expect(response.media_type).to eq("text/html")
      expect(response.body).to include("No repositories yet")
      expect(Nokogiri::HTML5(response.body).at_css(".alert")).to be_present
    end

    it "renders repository cards with the full name and default_base_ref" do
      stub_github_client_success

      Repository.create!(
        provider: "github",
        namespace_path: "acme/platform",
        name: "loki"
      )
      Repository.create!(
        provider: "gitlab",
        namespace_path: "acme/tools",
        name: "atlas",
        default_base_ref: "develop"
      )

      get "/repositories"

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("github", "acme/platform/loki", "main")
      expect(response.body).to include("gitlab", "acme/tools/atlas", "develop")
      expect(Nokogiri::HTML5(response.body).css(".card").count).to eq(2)
    end

    it "routes to repositories#index" do
      route = Rails.application.routes.recognize_path("/repositories", method: :get)

      expect(route).to include(controller: "repositories", action: "index")
    end

    it "includes a link to add a new repository" do
      get "/repositories"

      expect(response.body).to include(new_repository_path)
    end
  end

  describe "GET /repositories/new" do
    it "returns 200 and renders the form" do
      get "/repositories/new"

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Add Repository")
    end

    it "renders form fields for owner and name" do
      get "/repositories/new"

      doc = Nokogiri::HTML5(response.body)
      expect(doc.at_css("input[name='repository[namespace_path]']")).to be_present
      expect(doc.at_css("input[name='repository[name]']")).to be_present
      expect(doc.at_css("input[name='repository[default_base_ref]']")).not_to be_present
    end

    it "routes to repositories#new" do
      route = Rails.application.routes.recognize_path("/repositories/new", method: :get)

      expect(route).to include(controller: "repositories", action: "new")
    end
  end

  describe "POST /repositories" do
    let(:valid_params) do
      {
        repository: {
          namespace_path: "acme",
          name: "loki"
        }
      }
    end

    context "with valid data and accessible GitHub repository" do
      it "creates the repository and redirects to index" do
        stub_github_client_success

        expect {
          post "/repositories", params: valid_params
        }.to change(Repository, :count).by(1)

        expect(response).to redirect_to(repositories_path)
        follow_redirect!
        expect(response.body).to include("Repository added successfully")
      end

      it "sets default_base_ref from GitHub metadata" do
        stub_github_client_success(default_branch: "develop")

        post "/repositories", params: valid_params

        expect(Repository.last.default_base_ref).to eq("develop")
      end
    end

    context "when repository is not found on GitHub" do
      it "re-renders the form with error message" do
        stub_github_client_error(GithubClient::NotFoundError, "Repository not found on GitHub")

        post "/repositories", params: valid_params

        expect(response).to have_http_status(:unprocessable_content)
        expect(response.body).to include("Repository not found on GitHub")
      end
    end

    context "when access is denied" do
      it "re-renders the form with error message" do
        stub_github_client_error(
          GithubClient::AccessDeniedError,
          "Cannot access this repository. Check if it exists and the token has permission."
        )

        post "/repositories", params: valid_params

        expect(response).to have_http_status(:unprocessable_content)
        expect(response.body).to include("Cannot access this repository. Check if it exists and the token has permission.")
      end
    end

    context "when rate limit is exceeded" do
      it "re-renders the form with error message" do
        stub_github_client_error(GithubClient::RateLimitError, "GitHub API rate limit exceeded. Please try again later.")

        post "/repositories", params: valid_params

        expect(response).to have_http_status(:unprocessable_content)
        expect(response.body).to include("GitHub API rate limit exceeded. Please try again later.")
      end
    end

    context "when connection fails" do
      it "re-renders the form with error message" do
        stub_github_client_error(GithubClient::ConnectionError, "Could not connect to GitHub. Please try again.")

        post "/repositories", params: valid_params

        expect(response).to have_http_status(:unprocessable_content)
        expect(response.body).to include("Could not connect to GitHub. Please try again.")
      end
    end

    context "when GitHub token is not configured" do
      it "raises an exception and returns 500" do
        allow(GithubClient).to receive(:new).and_raise(
          GithubClient::ConfigurationError, "GitHub access token is not configured"
        )

        expect {
          post "/repositories", params: valid_params
        }.to raise_error(GithubClient::ConfigurationError)
      end
    end

    context "when repository already exists" do
      it "re-renders the form with duplicate error" do
        stub_github_client_success

        Repository.create!(
          provider: "github",
          namespace_path: "acme",
          name: "loki"
        )

        post "/repositories", params: valid_params

        expect(response).to have_http_status(:unprocessable_content)
        expect(response.body).to include("has already been taken")
      end
    end

    it "does not create repository without required fields" do
      post "/repositories", params: { repository: { namespace_path: "", name: "" } }

      expect(response).to have_http_status(:unprocessable_content)
      expect(Repository.count).to eq(0)
    end

    it "ignores submitted provider and always creates with github" do
      stub_github_client_success

      expect {
        post "/repositories", params: valid_params.deep_merge(repository: { provider: "gitlab" })
      }.to change(Repository, :count).by(1)

      expect(Repository.last.provider).to eq("github")
    end

    context "when validation fails" do
      it "re-renders form with submitted field values" do
        stub_github_client_error(GithubClient::NotFoundError, "Repository not found on GitHub")

        post "/repositories", params: { repository: { namespace_path: "acme", name: "missing" } }

        expect(response.body).to include("acme", "missing")
      end
    end
  end
end
