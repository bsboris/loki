class RepositoriesController < ApplicationController
  def index
    repositories = Repository.order(:provider, :namespace_path, :name)

    render locals: { repositories: }
  end
end
