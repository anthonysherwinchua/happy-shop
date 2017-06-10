require 'rails_helper'

RSpec.describe V1::ProductsQuery, type: :query do

  subject { described_class.new(sort_params, page_params) }

  context 'with pagination' do

    let!(:products_1) { create_list(:product, 10) }
    let!(:products_2) { create_list(:product, 10) }

    let(:sort_params) { nil }
    let(:page_params) { { number: number, size: size} }

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

    let(:page_params) { nil }

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

end
