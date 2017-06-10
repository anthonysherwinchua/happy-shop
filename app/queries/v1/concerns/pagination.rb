module V1::Concerns::Pagination

  extend ActiveSupport::Concern

  included do

    attr_accessor :page_params

    DEFAULT_PAGE_NUMBER = 1
    DEFAULT_PAGE_SIZE = 10

    private

    def page_params
      @page_params || {}
    end

    def page_number
      @page_number ||= page_params[:number] || DEFAULT_PAGE_NUMBER
    end

    def page_size
      @page_size ||= page_params[:size] || DEFAULT_PAGE_SIZE
    end

  end

end
