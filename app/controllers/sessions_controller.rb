class SessionsController < ApplicationController
  def new

  end


  def create
    user=User.find_by(email:params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password]) #valid sign in
      sign_in user
      redirect_back_or(user)
    else #invalid sign in
      flash.now[:error] = "Invalid email/password combination" #not quite right!
      render :new
    end
  end


  def destroy
    sign_out
    redirect_to root_path
  end
end
