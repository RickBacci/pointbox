class Admin::BaseController < ApplicationController

#  private
  before_action :require_admin

  def require_admin
    render file: "/public/404.html" unless current_admin?       
  end
end
