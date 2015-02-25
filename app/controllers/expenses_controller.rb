class ExpensesController < ApplicationController
  def create
    @expense = Expense.new(expense_params)
    @expense.date = Date.today unless @expense.date
    @expense.save
    redirect_to :back
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy
    redirect_to :back
  end
private
  def expense_params
    params.require(:expense).permit(:description, :amount, :shift_or_user_type, :shift_or_user_id, :supplier_id, :date)
  end
end
