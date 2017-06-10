class V1::BaseDecorator < SimpleDelegator

  include ActiveModel::Serialization

  class << self

    def wrap(collection)
      collection.map { |record| self.new(record) }
    end

  end

  ## overriding this so the `type` in the json response is the same as the record's class name
  def class
    __getobj__.class
  end

end





