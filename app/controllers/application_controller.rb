class ApplicationController < ActionController::API

  def page_params
    params.fetch(:page).permit(:number, :size)
  end

end
