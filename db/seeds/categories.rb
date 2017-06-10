puts 'Preparing categories'

categories_attributes = [
  { name: 'makeup' },
  { name: 'tools' },
  { name: 'brushes' }
]

puts 'Creating categories'
Category.create!(categories_attributes)

puts "Created #{Category.count} categories"
