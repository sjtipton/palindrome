class LearningResourcesController < ApplicationController

  def index
    @search_query_params = { keywords: params[:keywords] }
    @search_query = SearchQuery.new(@search_query_params)

    if @search_query.valid?
      Jefferson::LearningResource.api_query(any_tags: @search_query.keywords) { |lrs| @learning_resources = lrs }
      Jefferson::Config.hydra.run
    end
  end

end