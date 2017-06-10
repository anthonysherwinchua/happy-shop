class Category < ApplicationRecord

  has_many :products, inverse_of: :category

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 50 }

end
