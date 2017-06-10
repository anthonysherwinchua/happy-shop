require 'rails_helper'

RSpec.describe V1::ProductsController, type: :controller do

  let(:key) { 'Content-Type' }
  let(:value) { 'application/json; version=1' }
  let(:header) { instance_double(ActionDispatch::Http::Headers) }

  before do
    allow(ActionDispatch::Http::Headers).to receive(:new).and_return(header)
    allow(header).to receive(:fetch).with(key).and_return(value)
  end

  it do
    expect(get: '/products').to route_to('v1/products#index')
  end

  it do
    expect(get: '/products/1').to route_to('v1/products#show', id: '1')
  end

end
