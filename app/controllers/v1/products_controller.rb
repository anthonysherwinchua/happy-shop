class V1::ProductsController < ApplicationController

  def index
    query = V1::ProductsQuery.new(page_params)
    render json: query.call, each_serializer: ::V1::ProductSerializer
  end

end
