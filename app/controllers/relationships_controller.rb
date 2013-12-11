class RelationshipsController < ApplicationController

  def create
    #followed_user=User.find(params[:user][:id])
    #@relationship=current_user.relationships.build(followed_id: followed_user.id)
    #unless current_user.follow!(followed_user)
    #  current_user.follow!(followed_user)
    #end

    current_user.relationships.create(followed_id: params[:relationship][:followed_id])
    flash[:success]="You have followed that guy successfully"
    store_current_location
    redirect_back_or(current_user)
  end


  def destroy
    current_user.relationships.find_by(followed_id: params[:relationship][:followed_id]).destroy
    flash[:success]="You have unfollowed that guy"
    store_current_location
    redirect_back_or(current_user)
  end









end