require 'rails_helper'

RSpec.describe V1::ProductsController, type: :controller do

  describe 'GET #index' do

    subject { get :index, params: params }

    let(:category_1) { create(:category) }
    let!(:products_1) { create_list(:product, 50, category: category_1) }

    let(:category_2) { create(:category) }
    let!(:products_2) { create_list(:product, 50, category: category_2) }

    context 'with valid parameters' do

      let(:params) { { filter: { category: category_1.name, min_price: 1, max_price: 100 }, sort: '-price', page: { number: 3, size: 10 } } }

      it { is_expected.to have_http_status(200) }

    end

    context 'with invalid parameters' do

      let(:params) { { filter: { category: category_1.name, min_price: 1, max_price: 100 }, sort: '-name', page: { number: 3, size: 10 } } }

      it { is_expected.to have_http_status(422) }

    end

  end

end
