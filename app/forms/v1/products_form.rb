class V1::ProductsForm < V1::BaseForm

  attr_accessor :products_params, :sort_params, :page_params

  attr_accessor :products

  validates :sort_params, inclusion: { in: ['price', '-price'], message: 'invalid attribute' }, allow_nil: true
  validate :page_number_must_be_positive
  validate :page_size_must_be_positive
  validate :category_must_be_valid
  validate :gte_must_be_valid
  validate :lte_must_be_valid
  validate :price_range_must_be_valid

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

  def page_number_must_be_positive
    return true if page_params.blank?
    errors.add(:page_params, 'invalid page number') if page_params[:number] && page_params[:number].to_i <= 0
  end

  def page_size_must_be_positive
    return true if page_params.blank?
    errors.add(:page_params, 'invalid page size') if page_params[:size] && page_params[:size].to_i <= 0
  end

  def category_must_be_valid
    return true if products_params.blank?
    if products_params[:category] && !Category.exists?(name: products_params[:category])
      errors.add(:products_params, 'invalid filter: category')
    end
  end

  def gte_must_be_valid
    return true if products_params.blank?
    errors.add(:products_params, 'invalid filter: price range (gte)') if gte && gte.to_i <= 0
  end

  def lte_must_be_valid
    return true if products_params.blank?
    errors.add(:products_params, 'invalid filter: price range (lte)') if lte && lte.to_i <= 0
  end

  def price_range_must_be_valid
    return true if products_params.blank?
    errors.add(:products_params, 'invalid filter: price range (gte >= lte)') if gte && lte && gte.to_i >= lte.to_i
  end

  def gte
    @gte ||= products_params.dig(:price, :gte)
  end

  def lte
    @lte ||= products_params.dig(:price, :lte)
  end

end
