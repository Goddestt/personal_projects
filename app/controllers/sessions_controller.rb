class SessionsController < ApplicationController
  skip_before_action :authenticate

  STAFF = "1"
  REMEMBERED = "1"

  def new
  end

  def create
    if params[:session][:is_staff] == STAFF
      user = Staff.find_by(email: params[:session][:email].downcase)
    else
      user = User.find_by(email: params[:session][:email].downcase)
    end

    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == REMEMBERED ? remember(user) : forget(user)
      redirect_to root_path
    else
      render "new"
    end
  end

  def destroy
    log_out
    redirect_to login_path
  end
end
