module SessionsHelper
  # Tao mot session co ten la user_id.
  def log_in user
    session[:user_id] = user.id
  end

  # Tra ve doi tuong user hien tai.
  def current_user
    if user_id = session[:user_id]
      @current_user ||= User.find_by(id: user_id)
    elsif user_id = cookies.signed[:user_id]
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Tra lai true khi da login, nguoc laij false.
  def logged_in?
    !current_user.nil?
  end

  # Dang xuat.
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  # Remembers a user in a persistent session.
  def remember user
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Forgets a persistent session.
  def forget user
    user.forget
    cookies.delete :user_id
    cookies.delete :remember_token
  end
end
