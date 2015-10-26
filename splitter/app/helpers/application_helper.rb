module ApplicationHelper
  def login(user)
    session[:user_id] = user.id
    @current_user = user
  end

  def current_user
    @current_user ||= User.find(session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
  end
end
