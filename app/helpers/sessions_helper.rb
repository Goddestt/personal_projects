module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
    session[:user_type] = user.model_name.name
  end

  def current_user
    if (user_id = session[:user_id]) && (user_type = session[:user_type])
      @current_user ||= user_type.constantize.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id]) && (user_type = cookies.signed[:user_type])
      user = user_type.constantize.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    forget(current_user)
    session.clear
    @current_user = nil
  end

  # Make the user's session permanent
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_type] = user_type
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Delete the permanent session
  def forget(user)
    user.forget
    cookies.delete(:user_type)
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def current_user?(user)
    user == current_user
  end
end
