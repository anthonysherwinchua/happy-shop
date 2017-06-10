class V1::BaseSerializer < ActiveModel::Serializer

  def as_json(options = nil)
    {
      data: {
        attributes: super(options)
      }
    }
  end

end
