class ApplicationController < ActionController::API

  private

  def page_params
    params.fetch(:page).permit(:number, :size)
  end

end
