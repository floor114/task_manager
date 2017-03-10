class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def process_params!(params)
    params[:current_user] = current_user
  end
end
