class RelationsController < ApplicationController
  def new
    @relation = Relation.new
  end

  def create
    @relation = Relation.new(relation_params) 
    if @relation.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def relation_params
    params.require(:relation).permit(:following_id, :follower_id)
  end
end
