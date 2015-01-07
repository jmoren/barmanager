class ExpensesController < ApplicationController
  def create
    @shift = Shift.find(params[:shift_id])
    @expense = @shift.expenses.create(expense_params)
    redirect_to @shift
  end

  def destroy
    @shift = Shift.find(params[:shift_id])
    @expense = @shift.expenses.find(params[:id])
    @expense.destroy
    redirect_to @shift
  end
private
  def expense_params
    params.require(:expense).permit(:description, :amount)
  end
end
