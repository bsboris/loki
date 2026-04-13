module GithubClientHelpers
  def stub_github_client_success(default_branch: "main")
    github_client = instance_double(GithubClient, fetch_repository: default_branch)
    allow(GithubClient).to receive(:new).and_return(github_client)
    github_client
  end

  def stub_github_client_error(error_class, message)
    github_client = instance_double(GithubClient)
    allow(GithubClient).to receive(:new).and_return(github_client)
    allow(github_client).to receive(:fetch_repository).and_raise(error_class, message)
    github_client
  end
end
