class UsersController < SessionsController
  before_action :load_user, except: %i(index new create)
  before_action :logged_in_user, only: %i(show create new)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def show;end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = t("check_email")
      redirect_to root_url
    else
      render :new
    end
  end

  def edit;end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = t("profile_update")
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    return unless @user
    @user.destroy
    flash[:success] = t("deleted")
    redirect_to users_url
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:success] = t("user_not_found")
    redirect_to root_path
  end

  private

    def user_params
      params.require(:user).permit :name, :email, :password,
        :password_confirmation
    end

    # Confirms a logged-in user.
    def logged_in_user
      return if logged_in?
      store_location
      flash[:danger] = t("plz_login")
      redirect_to login_url
    end

    # Confirms the correct user.
    def correct_user
      redirect_to(root_url) unless current_user?(@user)
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
