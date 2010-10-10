class UsersController < ApplicationController
  
  before_filter :except=>[:new] do |c| c.send(:require_role, :administrator) end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if User.count < 2
      @user.add_role 'administrator'
    end
    if @user.save
      flash[:notice] = "Thank you for signing up! You are now logged in."
      redirect_to root_url
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
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    if @user.save 
      redirect_to users
    else 
      render action=>:edit
    end
 
  end
  
  def destroy
    User.find(params[:id]).destroy
    redirect_to users
  
  end
  

end
