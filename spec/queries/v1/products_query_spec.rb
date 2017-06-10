require 'rails_helper'

RSpec.describe V1::ProductsQuery, type: :query do

  subject { described_class.new(products_params, sort_params, page_params) }

  let(:products_params) { {} }
  let(:sort_params) { nil }
  let(:page_params) { nil }

  context 'with pagination' do

    let!(:products_1) { create_list(:product, 10) }
    let!(:products_2) { create_list(:product, 10) }

    let(:page_params) { { number: number, size: size } }

    describe 'page 1; size 10' do

      let(:number) { 1 }
      let(:size) { 10 }

      it { expect(subject.call).to eq(products_1) }

    end

    describe 'page 2; size 10' do

      let(:number) { 2 }
      let(:size) { 10 }

      it { expect(subject.call).to eq(products_2) }

    end

    describe 'page 3; size 5' do

      let(:number) { 3 }
      let(:size) { 5 }

      it { expect(subject.call).to eq(products_2[0..4]) }

    end

  end

  context 'with sorting' do

    let!(:product_1) { create(:product, name: 'Apple', price: 1) }
    let!(:product_2) { create(:product, name: 'Apple', price: 3) }
    let!(:product_3) { create(:product, name: 'Apple', price: 5) }
    let!(:product_4) { create(:product, name: 'Banana', price: 2) }
    let!(:product_5) { create(:product, name: 'Banana', price: 4) }

    describe 'sort by name, then by price' do

      let(:sort_params) { 'name,price' }
      let(:result) do
        [
          product_1,
          product_2,
          product_3,
          product_4,
          product_5
        ]
      end

      it { expect(subject.call).to eq(result) }

    end

    describe 'sort by -name, then by price' do

      let(:sort_params) { '-name,price' }
      let(:result) do
        [
          product_4,
          product_5,
          product_1,
          product_2,
          product_3
        ]
      end

      it { expect(subject.call).to eq(result) }

    end

    describe 'sort by name, then by -price' do

      let(:sort_params) { 'name,-price' }
      let(:result) do
        [
          product_3,
          product_2,
          product_1,
          product_5,
          product_4
        ]
      end

      it { expect(subject.call).to eq(result) }

    end

    describe 'sort by -name, then by -price' do

      let(:sort_params) { '-name,-price' }
      let(:result) do
        [
          product_5,
          product_4,
          product_3,
          product_2,
          product_1
        ]
      end

      it { expect(subject.call).to eq(result) }

    end

  end

  context 'with filtering' do

    describe 'category filter' do

      let!(:category_1) { create(:category) }
      let!(:category_2) { create(:category) }

      let!(:products_1) { create_list(:product, 3, category: category_1) }
      let!(:products_2) { create_list(:product, 2, category: category_2) }

      context 'when category is set to the first one' do

        let(:products_params) { { category: category_1.name } }

        it { expect(subject.call).to contain_exactly(*products_1) }

      end

      context 'when category is set to the second one' do

        let(:products_params) { { category: category_2.name } }

        it { expect(subject.call).to contain_exactly(*products_2) }

      end

    end

    describe 'price range filter' do

      let!(:product_1) { create(:product, under_sale: false, price: 100, sale_price: 50) }
      let!(:product_2) { create(:product, under_sale: false, price: 200, sale_price: 100) }
      let!(:product_3) { create(:product, under_sale: true, price: 300, sale_price: 150) }
      let!(:product_4) { create(:product, under_sale: true, price: 400, sale_price: 200) }

      context 'when price is set to be greater than or equal to 150' do

        let(:products_params) { { price: { gte: 150 } } }
        let(:result) do
          [
            product_2,
            product_3,
            product_4
          ]
        end

        it { expect(subject.call).to eq(result) }

      end

      context 'when price is set to be less than or equal to 150' do

        let(:products_params) { { price: { lte: 150 } } }
        let(:result) do
          [
            product_1,
            product_3
          ]
        end

        it { expect(subject.call).to eq(result) }

      end

      context 'when price is set to be between 100 and 150' do

        let(:products_params) { { price: { gte: 200, lte: 250 } } }
        let(:result) do
          [
            product_2,
            product_4
          ]
        end

        it { expect(subject.call).to eq(result) }

      end

    end

  end

end
