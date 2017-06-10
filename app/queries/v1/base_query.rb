class V1::BaseQuery

  include V1::Concerns::Sorting
  include V1::Concerns::Pagination

  def initialize(sort_params = '', page_params = {})
    @sort_params = sort_params
    @page_params = page_params
  end

end
