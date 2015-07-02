class Admin::CategoriesController < AdminController
  before_filter :get_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
    respond_to do |format|
      format.html { render action: 'index' }
      format.json { render json: { categories: Category.category_presenter } }
    end
    
  end

  def new
    @category = Category.new()
  end

  def create
    @category = Category.new(category_params)
    respond_to do |format|
      if @category.save
        format.html { redirect_to admin_categories_url, alert: t('controllers.categories.successfully_created') }
        format.json { render action: 'index', status: :created, location: @category }
      else
        format.html { render action: 'new' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @category.update_attributes(category_params)
        format.html { redirect_to admin_categories_url, alert: t('controllers.categories.successfully_updated') }
        format.json { render action: 'index', status: :created, location: @category }
      else
        format.html { render action: 'new' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    category.destroy
    respond_to do |format|
      format.html { redirect_to admin_categories_url, notice: t('controllers.categories.successfully_destroyed') }
      format.json { head :no_content }
    end
  end

  protected

  def category
    @category
  end

  def get_category
    @category = Category.find_by(id: params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :category_id)
  end
end