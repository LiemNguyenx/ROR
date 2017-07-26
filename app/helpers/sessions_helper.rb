module SessionsHelper
  # Tao mot session co ten la user_id.
  def log_in user
    session[:user_id] = user.id
  end

  # Tra ve doi tuong user hien tai.
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
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
end
