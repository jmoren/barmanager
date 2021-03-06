class UsersController < ApplicationController
  load_and_authorize_resource
  layout "admin"

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  def monthly_detail
    month = params[:month]
    date = Date.new(Date.today.year, month.to_i, 1)
    @user = User.find(params[:id])
    @expenses = @user.monthly_expenses(date)
    @extractions = @user.monthly_extractions(date).where(personal: false)
    @vales = @user.monthly_extractions(date).where(personal: true)
    @difference = @extractions.sum(:amount) + @vales.sum(:amount) - @expenses.sum(:amount)
    render :monthly_detail, layout: false
  end

private
  def user_params
    params.require(:user).permit(:email, :role, :username, :password, :password_confirmation)
  end
end
