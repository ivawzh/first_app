class MicropostsController < ApplicationController
  before_action :signed_in_user

  def create
    post=current_user.microposts.build(content: micropost_params[:content])
    if post.save
      flash[:success]="Micropost created!"
      redirect_to root_url
    else
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