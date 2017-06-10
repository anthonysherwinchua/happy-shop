class V1::CategorySerializer < V1::BaseSerializer

  attributes :name

  has_many :products, serializer: V1::ProductSerializer

end
