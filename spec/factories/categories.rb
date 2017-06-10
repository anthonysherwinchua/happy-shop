FactoryGirl.define do

  factory :category do
    sequence(:name) { |i| "Category ##{i}" }

    trait :invalid do
      name nil
    end
  end

end
