class V1::ProductDecorator < V1::BaseDecorator

  def price
    super / 100.00
  end

  def sale_price
    super / 100.00
  end

end
