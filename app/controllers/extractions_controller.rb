class ExtractionsController < ApplicationController
  def create
    shift = Shift.find(params[:shift_id])
    @extraction = shift.extractions.create(extractions_params)
    redirect_to :back
  end

  def destroy
    @shift = Shift.find(params[:shift_id])
    @extraction = @shift.extractions.find(params[:id])
    @extraction.destroy
    redirect_to :back
  end
private
  def extractions_params
    params.require(:extraction).permit(:description, :amount)
  end
end
