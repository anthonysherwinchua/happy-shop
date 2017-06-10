class V1::ProductsQuery < V1::BaseQuery

  def call
    Product.order(sort_string)
      .page(page_number).per(page_size)
  end

end
