class FacilitiesController < ApplicationController
  def index
    @facilities = Facility.order(:name).page(params[:page]).per(10)
  end

  def show
    @facility = Facility.find(params[:id])
  end
end
