class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :get_tables, :current_shift


  def get_tables
    @categories = Category.order(:name)
    @open_tables = Table.open.order(:description)
    @closed_tables = Table.closed.order(:description)
  end

  def current_shift
    @current_shift = Shift.last_open
  end
end
