class ExpensesController < ApplicationController
  def create
    type = params[:type]
    owner = type == "Shift" ? Shift.find(params[:shift_id]) : DailyCash.find(params[:daily_cash_id])
    @expense = owner.expenses.create(expense_params)
    redirect_to :back
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
