class ApiConstraint
  attr_reader :version

  def initialize(version:)
    @version = version
  end

  def matches?(request)
    request
      .headers
      .fetch('Content-Type')
      .include?("version=#{version}")
  end
end
