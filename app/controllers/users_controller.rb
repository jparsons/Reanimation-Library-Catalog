class UsersController < ApplicationController

  before_filter :except=>[:new, :create] do |c| c.send(:require_role, :administrator) end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if User.count < 2
      @user.role = "administrator"
    end
    if @user.save
      flash[:notice] = "User successfully created"
      redirect_to users_path
    else
      render :action => 'new'
    end
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])

  end

  def update
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
    if @user.save
      redirect_to users_path
    else
      render :edit
    end

  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_path

  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :username,
      :password,
      :password_confirmation,
      :role
    )

  end


end
