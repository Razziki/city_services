class ServicesController < ApplicationController
  def index
    @services = Service.order(:name).page(params[:page]).per(10)
  end

  def show
    @service = Service.find(params[:id])
  end
end
