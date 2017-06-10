class V1::ProductsForm < V1::BaseForm

  attr_accessor :products_params, :sort_params, :page_params

  attr_accessor :products

  validates :sort_params, inclusion: { in: ['price', '-price'], message: 'invalid attribute' }, allow_nil: true
  validate :page_params_must_be_positive
  validate :product_params_must_be_valid

  def initialize(products_params, sort_params, page_params)
    @products_params = products_params
    @sort_params = sort_params
    @page_params = page_params
  end

  def save
    return false unless valid?
    @products = V1::ProductsQuery.new(products_params, sort_params, page_params).call
  end

  private

  def page_params_must_be_positive
    return true if page_params.blank?
    errors.add(:page_params, 'invalid page number') if page_params[:number] && page_params[:number].to_i <= 0
    errors.add(:page_params, 'invalid page size') if page_params[:size] && page_params[:size].to_i <= 0
  end

  def product_params_must_be_valid
    return true if products_params.blank?
    errors.add(:products_params, 'invalid filter: category') if products_params[:category] && !Category.exists?(name: products_params[:category])
    gte = products_params.dig(:price, :gte)
    lte = products_params.dig(:price, :lte)
    errors.add(:products_params, 'invalid filter: price range (gte)') if gte && gte.to_i <= 0
    errors.add(:products_params, 'invalid filter: price range (lte)') if lte && lte.to_i <= 0
    errors.add(:products_params, 'invalid filter: price range (gte >= lte)') if gte && lte && gte.to_i >= lte.to_i
  end

end
