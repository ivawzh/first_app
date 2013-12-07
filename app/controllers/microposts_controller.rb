class MicropostsController < ApplicationController
  before_action :signed_in_user

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
  end
end


private

def micropost_params
  params.require(:micropost).permit(:content)
end