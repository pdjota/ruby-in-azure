class WelcomeController < ApplicationController
  skip_before_action :require_login, only: [ :index ]

  def index
    # Welcome page - accessible without login
    # If user is logged in, show personalized greeting
  end
end
