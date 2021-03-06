class UsersController < ApplicationController
  before_action :authenticate, except: [:new, :create]

  def index
    @users = User.all
  end

  def new
    @user = User.new 
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path 
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])    
    @points = @user.points
  end
 
  private

  def user_params
    params.require(:user).permit([:name, :password, :role])
  end
end
