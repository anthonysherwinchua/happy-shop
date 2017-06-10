require 'rails_helper'

RSpec.describe V1::ProductsController, type: :controller do

  describe 'GET #index' do

    subject { get :index, params: params }

    let(:category_1) { create(:category) }
    let!(:products_1) { create_list(:product, 50, category: category_1) }

    let(:category_2) { create(:category) }
    let!(:products_2) { create_list(:product, 50, category: category_2) }

    context 'with valid parameters' do

      let(:params) do
        {
          filter: {
            category: category_1.name,
            price: {
              gte: 1,
              lte: 10
            }
          },
          sort: '-price',
          page: {
            number: 3,
            size: 10
          }
        }
      end

      it { is_expected.to have_http_status(200) }

    end

    context 'with invalid parameters' do

      let(:params) do
        {
          filter: {
            category: 'lipsticks',
            price: {
              gte: -1,
              lte: -2
            }
          },
          sort: '-name',
          page: {
            number: -3,
            size: -4
          }
        }
      end

      it { is_expected.to have_http_status(422) }

    end

  end

  describe 'GET #show' do

    context 'with valid id' do

      subject { get :show, params: { id: product } }

      let(:product) { create(:product) }

      it { is_expected.to have_http_status(200) }

    end

    context 'with invalid id' do

      subject { get :show, params: { id: 100 } }

      it { is_expected.to have_http_status(404) }
    end

  end

end
