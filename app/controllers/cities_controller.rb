class CitiesController < ApplicationController
  def index
    @search = params[:search].to_s.strip
    @cities = City.order(:name)

    if @search.present?
      query = "%#{@search}%"
      @cities = @cities.where("(name) LIKE ? OR (province) LIKE ?", query, query)
    end

    @cities = @cities.page(params[:page]).per(10)
  end

  def show
    @city = City.find(params[:id])
    # @facilities = @city.facilities.order(:name).page(params[:page]).per(10)
  end
end
