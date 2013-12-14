class RelationshipsController < ApplicationController
  before_action :signed_in_user

  def create
    @user=User.find_by(id: params[:relationship][:followed_id])
    current_user.follow! @user
    #flash[:success]="You have followed that guy successfully"
    respond_to do |format|
      format.html do
        store_current_location
        redirect_back_or(current_user)
      end
      format.js
    end
  end


  def destroy
    relationship=Relationship.find_by(id: params[:id])
    unless relationship.nil?
      @user=User.find(relationship.followed_id)
      relationship.destroy
    end
    respond_to do |format|
      format.html do
        #flash[:success]="You have unfollowed that guy"
        store_current_location
        redirect_back_or(current_user)
      end
      format.js
    end
  end









end