class CategoriesController < ApplicationController
  before_action :set_category, except: [:new, :create, :index]
  def index
    if params[:q]
      @categories = Category.where(name: params[:q])
      render json: { total: @categories.size }
    else
      @categories = Category.all
    end
  end

  def show
    @items = @category.items.order(description: :asc)
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category
    else
      render 'new'
    end
  end

  def update
    @category.update(category_params)
    redirect_to @category
  end

  def destroy
    @category.destroy
    redirect_to categories_path
  end
  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :kitchen)
  end
end
