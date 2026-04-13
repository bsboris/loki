class RepositoriesController < ApplicationController
  def index
    repositories = Repository.order(:provider, :namespace_path, :name)

    render locals: { repositories: }
  end

  def new
    repository = Repository.new(provider: "github")

    render locals: { repository: }
  end

  def create
    repository = Repository.new(repository_params.merge(provider: "github"))

    if repository.save
      redirect_to repositories_path, notice: "Repository added successfully."
    else
      render :new, locals: { repository: }, status: :unprocessable_content
    end
  end

  private

  def repository_params
    params.expect(repository: %i[namespace_path name])
  end
end
