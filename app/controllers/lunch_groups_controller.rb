class LunchGroupsController < ApplicationController
  
  def new
    @seed = (Random.new.rand * 100).to_i
    @groupings = LunchGrouper.new(@seed).group_employees
  end

  def create
  end

end