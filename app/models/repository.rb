class Repository < ApplicationRecord
  validates :provider, :namespace_path, :name, presence: true
  validates :name, uniqueness: { scope: %i[provider namespace_path] }

  before_validation :fetch_github_default_branch, on: :create, if: :github_with_required_fields?

  def github?
    provider == "github"
  end

  def github_with_required_fields?
    github? && namespace_path.present? && name.present?
  end

  def qualified_name
    "#{namespace_path}/#{name}"
  end

  private

  def fetch_github_default_branch
    self.default_base_ref = GithubClient.new.fetch_repository(qualified_name)
  rescue GithubClient::Error => e
    errors.add(:base, e.message)
  end
end
