require "rails_helper"

RSpec.describe Repository, type: :model do
  describe "validations" do
    it "requires provider, namespace_path, and name" do
      repository = described_class.new(
        provider: nil,
        namespace_path: nil,
        name: nil
      )

      expect(repository).not_to be_valid
      expect(repository.errors[:provider]).to include("can't be blank")
      expect(repository.errors[:namespace_path]).to include("can't be blank")
      expect(repository.errors[:name]).to include("can't be blank")
      expect(repository.errors[:default_base_ref]).to be_empty
    end

    it "validates uniqueness of name scoped to provider and namespace_path" do
      stub_github_client_success

      described_class.create!(
        provider: "github",
        namespace_path: "acme/platform",
        name: "loki"
      )

      duplicate = described_class.new(
        provider: "github",
        namespace_path: "acme/platform",
        name: "loki"
      )

      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:name]).to include("has already been taken")
    end

    it "allows the same name under a different provider or namespace_path" do
      stub_github_client_success

      described_class.create!(
        provider: "github",
        namespace_path: "acme/platform",
        name: "loki"
      )

      other_provider = described_class.new(
        provider: "gitlab",
        namespace_path: "acme/platform",
        name: "loki",
        default_base_ref: "main"
      )

      stub_github_client_success(default_branch: "trunk")
      other_namespace = described_class.new(
        provider: "github",
        namespace_path: "acme/infra",
        name: "loki"
      )

      expect(other_provider).to be_valid
      expect(other_namespace).to be_valid
      expect(other_namespace.default_base_ref).to eq("trunk")
    end

    context "when provider is github" do
      it "fetches default branch from GitHub and sets default_base_ref on create" do
        github_client = stub_github_client_success(default_branch: "develop")

        repository = described_class.create!(
          provider: "github",
          namespace_path: "acme",
          name: "loki"
        )

        expect(github_client).to have_received(:fetch_repository).with("acme/loki")
        expect(repository.default_base_ref).to eq("develop")
      end

      it "adds error when repository is not found on GitHub" do
        stub_github_client_error(GithubClient::NotFoundError, "Repository not found on GitHub")

        repository = described_class.new(provider: "github", namespace_path: "acme", name: "missing")

        expect(repository).not_to be_valid
        expect(repository.errors[:base]).to include("Repository not found on GitHub")
        expect(repository.errors[:default_base_ref]).to be_empty
      end

      it "adds error when access is denied" do
        stub_github_client_error(
          GithubClient::AccessDeniedError,
          "Cannot access this repository. Check if it exists and the token has permission."
        )

        repository = described_class.new(provider: "github", namespace_path: "acme", name: "private-repo")

        expect(repository).not_to be_valid
        expect(repository.errors[:base]).to include("Cannot access this repository. Check if it exists and the token has permission.")
      end

      it "adds error on rate limit" do
        stub_github_client_error(GithubClient::RateLimitError, "GitHub API rate limit exceeded. Please try again later.")

        repository = described_class.new(provider: "github", namespace_path: "acme", name: "loki")

        expect(repository).not_to be_valid
        expect(repository.errors[:base]).to include("GitHub API rate limit exceeded. Please try again later.")
      end

      it "adds error on connection failure" do
        stub_github_client_error(GithubClient::ConnectionError, "Could not connect to GitHub. Please try again.")

        repository = described_class.new(provider: "github", namespace_path: "acme", name: "loki")

        expect(repository).not_to be_valid
        expect(repository.errors[:base]).to include("Could not connect to GitHub. Please try again.")
      end

      it "raises ConfigurationError when GitHub token is not configured" do
        allow(GithubClient).to receive(:new).and_raise(GithubClient::ConfigurationError, "GitHub access token is not configured")

        expect {
          described_class.new(
            provider: "github",
            namespace_path: "acme",
            name: "loki"
          ).valid?
        }.to raise_error(GithubClient::ConfigurationError, "GitHub access token is not configured")
      end
    end

    context "when provider is not github" do
      it "skips GitHub fetch" do
        expect(GithubClient).not_to receive(:new)

        repository = described_class.new(
          provider: "gitlab",
          namespace_path: "acme",
          name: "loki",
          default_base_ref: "main"
        )

        repository.valid?
      end
    end
  end

  describe "default_base_ref" do
    it "is set from the GitHub repository default branch on create" do
      stub_github_client_success(default_branch: "trunk")

      repository = described_class.create!(
        provider: "github",
        namespace_path: "acme/platform",
        name: "loki"
      )

      expect(repository.reload.default_base_ref).to eq("trunk")
    end

    it "falls back to the database default for non-github repositories" do
      repository = described_class.create!(
        provider: "gitlab",
        namespace_path: "acme/platform",
        name: "loki"
      )

      expect(repository.reload.default_base_ref).to eq("main")
    end
  end

  describe "GitHub fetch on update" do
    it "does not call GithubClient when updating an existing record" do
      stub_github_client_success

      repository = described_class.create!(
        provider: "github",
        namespace_path: "acme",
        name: "loki"
      )

      expect(GithubClient).not_to receive(:new)
      repository.update!(namespace_path: "acme-org")
    end
  end

  describe "#qualified_name" do
    it "joins namespace_path and name" do
      repository = described_class.new(
        provider: "github",
        namespace_path: "acme/platform",
        name: "loki",
        default_base_ref: "main"
      )

      expect(repository.qualified_name).to eq("acme/platform/loki")
    end
  end

  describe "#github?" do
    it "returns true for github provider" do
      expect(described_class.new(provider: "github").github?).to be true
    end

    it "returns false for other providers" do
      expect(described_class.new(provider: "gitlab").github?).to be false
    end
  end

  describe "database constraints" do
    it "enforces unique provider, namespace_path, and name at the database level" do
      stub_github_client_success

      described_class.create!(
        provider: "github",
        namespace_path: "acme/platform",
        name: "loki"
      )

      expect {
        described_class.insert!({
          provider: "github",
          namespace_path: "acme/platform",
          name: "loki",
          default_base_ref: "main",
          created_at: Time.current,
          updated_at: Time.current
        })
      }.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end
end
