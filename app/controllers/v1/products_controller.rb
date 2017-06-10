class V1::ProductsController < ApplicationController

  def index
    render json: Product.all, each_serializer: ::V1::ProductSerializer
  end

end
