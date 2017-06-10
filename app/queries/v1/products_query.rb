class V1::ProductsQuery < V1::BaseQuery

  attr_accessor :products_params

  def initialize(products_params = {}, sort_params = {}, page_params = {})
    @products_params = products_params
    super(sort_params, page_params)
  end

  def call
    products = Product.all
    products = filter_by_category(products, @products_params[:category])
    products = filter_by_price_range(products, @products_params[:price])
    products.order(sort_string).page(page_number).per(page_size)
  end

  private

  def filter_by_category(products, category)
    return products if category.blank?
    products.where(category: Category.where(name: category))
  end

  def filter_by_price_range(products, price_range)
    return products if price_range.blank?
    products = filter_by_price_gte!(products, price_range[:gte])
    products = filter_by_price_lte!(products, price_range[:lte])
    products
  end

  def filter_by_price_gte!(products, price)
    filter_by_price(products, price, '>=')
  end

  def filter_by_price_lte!(products, price)
    filter_by_price(products, price, '<=')
  end

  def filter_by_price(products, price, operator)
    return products if price.blank?
    condition = [
      "(under_sale IS FALSE AND price #{operator} :price)",
      "(under_sale IS TRUE AND sale_price #{operator} :price)"
    ]
    products.where(condition.join('OR'), price: price)
  end

end
