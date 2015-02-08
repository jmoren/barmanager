class ExtractionsController < ApplicationController
  def create
    @extraction = Extraction.new(extractions_params)
    if !current_user.admin?
      @extraction.user_id = current_user.id
    end
    @extraction.shift_id = current_shift.id
    @extraction.save
    redirect_to :back
  end

  def destroy
    if current_user.admin?
      @user = User.find(params[:user_id])
    else
      @user = current_user
    end
    @extraction = @user.extractions.find(params[:id])
    @extraction.destroy
    redirect_to :back
  end
private
  def extractions_params
    params.require(:extraction).permit(:description, :amount, :user_id, :shift_id)
  end
end
