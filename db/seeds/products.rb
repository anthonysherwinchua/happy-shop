puts 'Preparing products'

def attribute_for_product(index, category)
  {
    name: "Product ##{index}",
    sold_out: [true, false].sample,
    under_sale: [true, false].sample,
    price: rand(2_147_483_647),
    sale_price: rand(2_147_483_647),
    category: category
  }
end

categories = Category.all

products_attributes = []

1.upto(100).each do |i|
  products_attributes << attribute_for_product(i, categories.sample)
end

puts 'Creating products'
Product.create!(products_attributes)

puts "Created #{Product.count} products"

