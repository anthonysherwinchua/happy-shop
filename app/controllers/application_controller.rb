class ApplicationController < ActionController::API

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found(error)
    error = { "errors": [{ "source": { "pointer": '/data/attributes/id' }, "detail": 'record not found' }] }
    render json: error, status: :not_found
  end

  def page_params
    params.fetch(:page, {}).permit(:number, :size)
  end

end
