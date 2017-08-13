class UsersController < SessionsController
  before_action :logged_in_user, except: %i(create new show)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy
  before_action :load_user, except: %i(index new create)

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @microposts = @user.microposts.paginate(page: params[:page])
  end

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

  def edit; end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = t("profile_update")
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = t("deleted")
    redirect_to users_url
  end

  def following
    @title = t("following_up")
    @user = User.find_by id: params[:id]
    @users = @user.following.paginate(page: params[:page])
    render "show_follow"
  end

  def followers
    @title = t("followers")
    @user = User.find_by id: params[:id]
    @user = User.find_by id: params[:id]
    @users = @user.followers.paginate(page: params[:page])
    render "show_follow"
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

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
