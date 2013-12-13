class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :index, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit,:update]
  before_action :admin_user, only: :destroy
  before_action :not_signed_in_user,only: [:new,:create]


  def index
    @users=User.paginate(page: params[:page])
  end


  def new
    @user=User.new
  end


  def show
    @user = User.find(params[:id])
    @microposts=@user.microposts.paginate(page: params[:page])
    unless current_user.nil?
      if current_user.following?(@user)
        @relationship=current_user.relationships.find_by(followed_id: @user.id)
      else
        @relationship=current_user.relationships.new
      end
    end
  end


  def create
    @user=User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App, #{ @user[:name] }!"
      sign_in @user
      redirect_to @user
    else
      render 'new'
    end
  end


  def edit
      @user = User.find(params[:id])
  end


  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success]="Profile updated"
      redirect_to @user
    else
      flash.now[:error]="Update failed"
      render 'edit'
    end
  end


  def destroy
    user=User.find(params[:id])
    user.destroy if current_user != user
    flash[:success]="#{user.name} (#{user.email}) is deleted successfully"
    store_current_location
    redirect_back_or(users_url)
  end


  def following
    @user=User.find(params[:id])
    @title = "Following of #{@user.name}"
    @followed_users = @user.followed_users.paginate(page: params[:page])
    render "users/following"
  end


  def followers
    @user=User.find(params[:id])
    @title="Followers of #{@user.name}"
    @followers = @user.followers.paginate(page: params[:page])
    render "users/followers"
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end


  #before filter


  def correct_user
    #if current_user != User.find_by_id(params[:id])
    #  flash[:error]="Sorry, you don't have the authority to edit this user's profile"
    #  redirect_to root_url
    #end
    @user = User.find_by_id(params[:id])
    unless current_user?(@user)
      flash[:error]="Sorry, you don't have the authority to edit this user's profile"
      redirect_to(root_url)
    end
  end


  def admin_user
    if !current_user.admin?
      flash[:error]="You don't have the right to delete this user"
      redirect_to(root_url)
    end
  end


  def not_signed_in_user
    if signed_in?
      flash[:error]="You can not create an new user account because you are already signed in"
      redirect_to(root_url)
    end
  end


end
