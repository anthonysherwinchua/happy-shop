class V1::ProductsController < ApplicationController

  def index
    query = V1::ProductsQuery.new(products_params, params[:sort], page_params)
    render json: query.call, each_serializer: ::V1::ProductSerializer
  end

  private

  def products_params
    params.fetch(:filter).permit(:category, price: [:gte, :lte])
  end

end
