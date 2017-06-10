require 'rails_helper'

RSpec.describe V1::ProductsController, type: :controller do

  describe 'GET #index' do

    it do
      get :index
      expect(response).to have_http_status(200)
    end

  end

end
