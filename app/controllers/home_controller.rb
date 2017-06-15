class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  def index
    if current_user.is_cooker?
      redirect_to kitchen_path
    end
  end

  def home
    render layout: "web"
  end

end
