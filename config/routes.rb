Rails.application.routes.draw do

  scope module: :v1, constraints: ApiConstraint.new(version: 1), format: :json do

    resources :products, only: [:index, :show]

  end

end
