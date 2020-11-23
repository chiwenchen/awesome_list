class RouterController < ApplicationController
  def index
    _, @tech_name, @category_name, @repository_name = request.path.split('/')

    route_mapping
  end

  def route_mapping(resource = nil)
    if resource.kind_of? Category
      @repositories = resource.repositories.inspect_raw
      @repository = @repositories.find_by(name: @repository_name)
      @repository ? render('repositories/show') : render('repositories/index')

    elsif resource.kind_of? Technology
      @categories = resource.categories
      category = @categories.find_by(name: @category_name)
      category ? route_mapping(category) : render('categories/index')

    elsif resource.nil?
      @technologies = Technology.all
      technology = @technologies.find_by(name: @tech_name)
      technology ? route_mapping(technology) : render('technologies/index')
    end
  end
end
