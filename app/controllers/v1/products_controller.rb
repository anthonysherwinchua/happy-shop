class V1::ProductsController < ApplicationController

  def index
    products = V1::ProductsQuery.new(products_params, params[:sort], page_params).call
    render json: V1::ProductDecorator.wrap(products), each_serializer: ::V1::ProductSerializer
  end

  private

  def products_params
    params.fetch(:filter, {}).permit(:category, price: [:gte, :lte])
  end

end
