require 'rails_helper'

RSpec.describe V1::ProductsQuery, type: :query do

  subject { described_class.new(page_params) }

  let!(:products_1) { create_list(:product, 10) }
  let!(:products_2) { create_list(:product, 10) }

  context 'with pagination' do

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

end
