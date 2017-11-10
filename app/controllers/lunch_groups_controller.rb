class LunchGroupsController < ApplicationController
  
  def new
    @seed = (Random.new.rand * 100).to_i
    @groupings = LunchGrouper.new(@seed).groupings
  end

  def create
  end

end