class V1::BaseQuery

  include V1::Concerns::Pagination

  def initialize(page_params = {})
    @page_params = page_params
  end

end
