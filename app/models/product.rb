class Product < ApplicationRecord

  belongs_to :category, inverse_of: :products

  validates :category, presence: true
  validates :name, presence: true, uniqueness: { scope: :category_id, case_sensitive: false }
  validates :price, presence: true, numericality: { greater_than: 0, less_than: 2_147_483_648 }
  validates :sale_price, presence: true, numericality: { greater_than: 0, less_than: 2_147_483_648 }

end
