class V1::ProductSerializer < V1::BaseSerializer

  attributes :name,
    :sold_out,
    :under_sale,
    :price,
    :sale_price

  belongs_to :category, serializer: V1::CategorySerializer

end
