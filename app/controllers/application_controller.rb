class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :get_tables, :current_shift

  before_filter :authenticate_user!
  
  def get_tables
    @categories = Category.order(:name)
    @open_tables = Table.open.order(:number)
    @closed_tables = Table.closed.order(:number)
  end

  def current_shift
    @current_shift = Shift.last_open
  end
end
