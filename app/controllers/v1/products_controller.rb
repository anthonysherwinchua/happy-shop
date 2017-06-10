class V1::ProductsController < ApplicationController

  def index
    form = V1::ProductsForm.new(products_params, params[:sort], page_params)
    if form.save
      render json: V1::ProductDecorator.wrap(form.products), each_serializer: ::V1::ProductSerializer
    else
      render json: form, serializer: ActiveModel::Serializer::ErrorSerializer, status: :unprocessable_entity
    end
  end

  def show
    @product = Product.find(params[:id])
    render json: V1::ProductDecorator.new(@product), serializer: ::V1::ProductSerializer
  end

  private

  def products_params
    params.fetch(:filter, {}).permit(:category, price: [:gte, :lte])
  end

end
