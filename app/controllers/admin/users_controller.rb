class Admin::UsersController < AdminController
  
  before_filter :get_user, only: [:edit, :update, :show, :diactivate, :activate]

  def index
    @users = User.all    
  end

  def show
  end

  def edit
  end

  def update
    
  end

  def delete

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
end