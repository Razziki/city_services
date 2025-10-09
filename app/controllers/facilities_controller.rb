class FacilitiesController < ApplicationController
  def index
    @cities  = City.order(:name)
    @city_id = params[:city_id].presence

    scope = Facility.order(:name)
    scope = scope.where(city_id: @city_id) if @city_id

    @facilities = scope.page(params[:page]).per(10)
  end

  def show
    @facility = Facility.find(params[:id])
  end
end
