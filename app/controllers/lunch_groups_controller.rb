class LunchGroupsController < ApplicationController
  
  def new
    @seed = (Random.new.rand * 100).to_i
    @groupings = LunchGrouper.new(seed: @seed).group_employees
  end

  def create
    @seed = params[:seed] #user passed in a seed to recreate
    if @lunch_group = LunchGrouper.new(seed: @seed).save!
      redirect_to lunch_group_path(@lunch_group)
    else
      flash[:error] = "There was a problem creating this group"
      redirect_to new_lunch_group_path
    end
  end

  def index
    @lunch_groups = LunchGroup.all
  end

  def show
    @lunch_group = LunchGroup.includes(groupings: :employees).find(params[:id])
  end

end