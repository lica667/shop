class Admin::UsersController < AdminController
  
  before_filter :get_user, only: [:edit, :update, :show, :diactivate, :activate, :destroy]

  def index
    @users = User.all    
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to admin_users_url, alert: t('controllers.users.successfully_updated') }
        format.json { render action: 'index', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy

  end

  def diactivate
    
  end

  def activate
    
  end

  protected
    def user
      @user
    end

    def get_user
      @user = User.find_by(id: params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :temp_password)
    end
end