class GithubClient
  class ConfigurationError < StandardError; end
  class Error < StandardError; end
  class NotFoundError < Error; end
  class AccessDeniedError < Error; end
  class RateLimitError < Error; end
  class ConnectionError < Error; end

  def initialize(token: Rails.application.credentials.dig(:github, :access_token))
    raise ConfigurationError, "GitHub access token is not configured" if token.blank?

    @client = Octokit::Client.new(access_token: token)
  end

  def fetch_repository(qualified_name)
    repo = @client.repository(qualified_name)
    branch = repo.default_branch
    raise NotFoundError, "Repository not found on GitHub" if branch.blank?

    branch
  rescue Octokit::NotFound
    raise NotFoundError, "Repository not found on GitHub"
  rescue Octokit::TooManyRequests
    raise RateLimitError, "GitHub API rate limit exceeded. Please try again later."
  rescue Octokit::Unauthorized
    raise AccessDeniedError, "Cannot access this repository. Check if it exists and the token has permission."
  rescue Octokit::Forbidden
    raise AccessDeniedError, "Cannot access this repository. Check if it exists and the token has permission."
  rescue Octokit::ClientError
    raise Error, "GitHub returned an unexpected error. Please try again."
  rescue Faraday::ConnectionFailed, Faraday::TimeoutError
    raise ConnectionError, "Could not connect to GitHub. Please try again."
  end
end
