require 'rails_helper'

RSpec.describe V1::ProductsController, type: :controller do

  describe 'GET #index' do

    subject { get :index, params: params }

    let!(:products) { create_list(:product, 100) }

    let(:params) { { sort: 'sale_price,-price', page: { number: 3, size: 10 } } }

    it { is_expected.to have_http_status(200) }

  end

end
