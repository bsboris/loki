require "rails_helper"

RSpec.describe GithubClient, type: :model do
  let(:token) { "test_token" }
  let(:octokit) { instance_double(Octokit::Client) }
  let(:client) { described_class.new(token:) }

  before do
    allow(Octokit::Client).to receive(:new).with(access_token: token).and_return(octokit)
  end

  describe ".new" do
    it "raises ConfigurationError when token is nil" do
      expect { described_class.new(token: nil) }.to raise_error(GithubClient::ConfigurationError, "GitHub access token is not configured")
    end

    it "raises ConfigurationError when token is blank" do
      expect { described_class.new(token: "") }.to raise_error(GithubClient::ConfigurationError, "GitHub access token is not configured")
    end
  end

  describe "#fetch_repository" do
    context "when the repository exists and is accessible" do
      it "returns the default branch" do
        allow(octokit).to receive(:repository).with("acme/loki").and_return(double(default_branch: "main"))

        expect(client.fetch_repository("acme/loki")).to eq("main")
      end
    end

    context "when the repository has no default branch" do
      it "raises NotFoundError" do
        allow(octokit).to receive(:repository).with("acme/empty-repo").and_return(double(default_branch: nil))

        expect { client.fetch_repository("acme/empty-repo") }
          .to raise_error(GithubClient::NotFoundError, "Repository not found on GitHub")
      end
    end

    context "when the repository is not found" do
      it "raises NotFoundError" do
        allow(octokit).to receive(:repository).and_raise(Octokit::NotFound)

        expect { client.fetch_repository("acme/nonexistent") }
          .to raise_error(GithubClient::NotFoundError, "Repository not found on GitHub")
      end
    end

    context "when an unexpected GitHub client error occurs" do
      it "raises Error with a generic message" do
        allow(octokit).to receive(:repository).and_raise(Octokit::UnprocessableEntity)

        expect { client.fetch_repository("acme/repo") }
          .to raise_error(GithubClient::Error, "GitHub returned an unexpected error. Please try again.")
      end
    end

    context "when access is denied (403)" do
      it "raises AccessDeniedError" do
        allow(octokit).to receive(:repository).and_raise(Octokit::Forbidden)

        expect { client.fetch_repository("acme/private-repo") }
          .to raise_error(GithubClient::AccessDeniedError, "Cannot access this repository. Check if it exists and the token has permission.")
      end
    end

    context "when authentication fails (401)" do
      it "raises AccessDeniedError" do
        allow(octokit).to receive(:repository).and_raise(Octokit::Unauthorized)

        expect { client.fetch_repository("acme/private-repo") }
          .to raise_error(GithubClient::AccessDeniedError, "Cannot access this repository. Check if it exists and the token has permission.")
      end
    end

    context "when rate limit is exceeded" do
      it "raises RateLimitError" do
        allow(octokit).to receive(:repository).and_raise(Octokit::TooManyRequests)

        expect { client.fetch_repository("acme/loki") }
          .to raise_error(GithubClient::RateLimitError, "GitHub API rate limit exceeded. Please try again later.")
      end
    end

    context "when there is a network connection failure" do
      it "raises ConnectionError" do
        allow(octokit).to receive(:repository).and_raise(Faraday::ConnectionFailed.new("connection refused"))

        expect { client.fetch_repository("acme/loki") }
          .to raise_error(GithubClient::ConnectionError, "Could not connect to GitHub. Please try again.")
      end
    end

    context "when there is a network timeout" do
      it "raises ConnectionError" do
        allow(octokit).to receive(:repository).and_raise(Faraday::TimeoutError.new("timeout"))

        expect { client.fetch_repository("acme/loki") }
          .to raise_error(GithubClient::ConnectionError, "Could not connect to GitHub. Please try again.")
      end
    end
  end
end
