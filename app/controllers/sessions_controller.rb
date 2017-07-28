class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      user.activated? ? checkbox_checked(user) : account_not_activated
    else
      invalid_info
    end
  end

  def invalid_info
    flash.now[:danger] = t("invalid_info")
    render :new
  end

  def account_not_activated
    flash[:warning] = t("account_not_activated")
    redirect_to root_url
  end

  def checkbox_checked user
    log_in user
    params[:session][:remember_me] == Settings.checkbox ? remember(user) : forget(user)
    redirect_back_or user
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
