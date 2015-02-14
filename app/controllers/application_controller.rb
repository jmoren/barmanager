class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :get_tables, :current_shift, :get_categories

  before_filter :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to home_index_path, alert: "No tenes permisos para ver esta pagina o realizar esa accion"
  end

  def get_tables
    return unless current_user
    @closed_tables  = Table.closed.order(id: :desc)
    @wtable_tickets = Ticket.with_table.opened
    @ntable_tickets = Ticket.without_table.opened
  end

  def current_shift
    return unless current_user
    @current_shift = Shift.last_open
  end

  def get_categories
    return unless current_user
    @categories = Category.order(:name)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :email, :password) }
  end
end
