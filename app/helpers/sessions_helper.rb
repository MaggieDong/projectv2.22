module SessionsHelper
  def log_in(user)
    session[:user_id]=user.id
  end

  def current_user
    @current_user||=Admin.find_by(email: session[:email])
    @current_user||=Developer.find_by(email: session[:email])
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:email)
    @current_user=nil
  end

  def current_user?(user)
    user==current_user
  end
end
