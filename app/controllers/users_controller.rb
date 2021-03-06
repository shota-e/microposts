class UsersController < ApplicationController
  before_action :set_user,:user_confirm, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    #binding.pry
    @user = User.find(params[:id])
    if @user.update(user_params)
      @user.save
      flash[:success] = "Update profile!"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation,:profile,:area)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_confirm
    @user = User.find(params[:id])
    if @user != current_user
      render 'static_pages/home'
    end
  end
  
end
