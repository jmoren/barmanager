class ExpensesController < ApplicationController
  def create
    is_shift = params[:user_id].nil?
    owner = is_shift ? Shift.find(params[:shift_id]) : User.find(params[:user_id])
    @expense = owner.expenses.create(expense_params)
    redirect_to :back
  end

  def destroy
    is_shift = params[:user_id].nil?
    owner = is_shift ? Shift.find(params[:shift_id]) : User.find(params[:user_id])
    @expense = owner.expenses.find(params[:id])
    @expense.destroy
    redirect_to :back
  end
private
  def expense_params
    params.require(:expense).permit(:description, :amount, :type)
  end
end
