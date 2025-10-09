class ServicesController < ApplicationController
  def index
    @search = params[:search].to_s.strip
    @services = Service.order(:name).page(params[:page]).per(10)

    if @search.present?
    query = "%#{@search}%"
    @services = @services.where("(name) LIKE ? ", query)
    end
  end

  def show
    @service = Service.find(params[:id])
  end
end
