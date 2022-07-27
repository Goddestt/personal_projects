class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :authenticate

  rescue_from ActiveRecord::RecordNotFound, with: :redirect_to_root

  private

  def authenticate
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def redirect_to_root
    redirect_to root_path
  end
end
