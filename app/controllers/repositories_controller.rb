class RepositoriesController < ApplicationController
  def index
    @repositories = Repository.all.inspect_raw
  end

  def show
    @repository = Repository.inspect_raw.find(query_params[:id])
  end

  def new
    @repository = RepositoryFormBuilder.new
  end

  def create
    response = Graphql::Client.query(Graphql::Queries::Repo, variables: {owner: repo_params['owner'], repo_name: repo_params['repo']})
    category = create_or_find_category

    @repository = Repository.new(name: repo_params['repo'], category: category, raw_data: response.json_data)
    @repository.save!

    redirect_to repository_path(@repository)
  rescue => e
    @repository = RepositoryFormBuilder.new(repo_params.to_h.symbolize_keys)
    # flash[:error] = e.message
    render :new
  end

  private

  def create_or_find_category
    tech_name = repo_params['technology_name'].parameterize(separator: '_')
    category_name = repo_params['category_name'].parameterize(separator: '_')

    technology = Technology.find_or_create_by(name: tech_name)
    category = technology.categories.find_or_create_by(name: category_name)

    return category
  end

  def repo_params
    params.require(:repository).permit(:owner, :repo, :technology_name, :category_name)
  end

  def query_params
    params.permit(:id)
  end
end
