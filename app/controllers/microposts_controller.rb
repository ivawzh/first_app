class MicropostsController < ApplicationController
  before_action :signed_in_user
  before_action :correct_user, only: :destroy

  def create
    @micropost=current_user.microposts.build(content: micropost_params[:content])
    if @micropost.save
      flash[:success]="Micropost created!"
      redirect_to root_url
    else
      #@feed_items=[]
      #render "static_pages/home"
      flash[:error]="Error: The entered micropost is not valid"
      redirect_to root_url
    end



  end

  def destroy
    @micropost_deleting.destroy
    #@micropost.destroy
    flash[:success]="You have deleted the microposts with content: #{ @micropost_deleting[:content]}"
    redirect_to root_url
  end



  private

  def micropost_params
    params.require(:micropost).permit(:content)
  end

  def correct_user
    @micropost_deleting = current_user.microposts.find(params[:id])
    rescue
        flash[:error]="Error: you don't have the authority to delete this post."
        redirect_to root_url
    end












end