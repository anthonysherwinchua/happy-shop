FactoryGirl.define do

  factory :product do
    association :category, factory: :category, strategy: :build

    sequence(:name) { |i| "Product ##{i}" }
    sold_out false
    under_sale false
    price 1
    sale_price 1

    trait :invalid do
      name nil
      price 0
      sale_price 2_147_483_648
    end

  end

end
