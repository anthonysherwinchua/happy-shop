module V1::Concerns::Sorting

  extend ActiveSupport::Concern

  included do

    attr_accessor :sort_params

    private

    def sort_params
      @sort_params || ''
    end

    def sort_string
      @sort_string ||= original_attributes.map do |attribute|
        "#{attribute.tr('-', '')} #{resolve_sort_direction(attribute)}"
      end
    end

    def original_attributes
      @original_attributes ||= sort_params.split(',')
    end

    def resolve_sort_direction(attribute)
      attribute.starts_with?('-') ? 'desc' : 'asc'
    end

  end

end
