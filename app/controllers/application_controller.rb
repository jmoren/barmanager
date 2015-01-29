class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :get_tables, :current_shift

  before_filter :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    puts "User: #{current_user.login}"
    redirect_to root_url, alert: exception.message
  end

  def get_tables
    @categories = Category.order(:name)
    @open_tables = Table.open.order(:description)
    @closed_tables = Table.closed.order(:description)
  end

  def current_shift
    @current_shift = Shift.last_open
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :email, :password) }
  end
end
