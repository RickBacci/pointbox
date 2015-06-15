class RewardsController < ApplicationController

  def new
    @reward = Reward.new
  end

  def create
    @reward = Reward.new(reward_params)

    if @reward.save
      redirect_to @reward
    else
      render :new
    end
  end
 
  def show
    @reward = Reward.find(params[:id])    
  end

  def edit
    @reward = Reward.find(params[:id])
  end


  def update
   reward = Reward.find(params[:id])
   reward.update(reward_params)

   redirect_to root_path
  end

 
  def destroy
    @reward = Reward.find(params[:id])
    @reward.destroy
    redirect_to root_path
  end

  private

  def reward_params
    params.require(:reward).permit(:name, :description)
  end
end
