require 'rails_helper'

RSpec.describe Product, type: :model do

  subject { build(:product) }

  it { is_expected.to belong_to(:category).inverse_of(:products) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:category_id).case_insensitive }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_presence_of(:sale_price) }
  it { is_expected.to validate_numericality_of(:price).is_greater_than(0).is_less_than(2_147_483_648) }
  it { is_expected.to validate_numericality_of(:sale_price).is_greater_than(0).is_less_than(2_147_483_648) }

end
