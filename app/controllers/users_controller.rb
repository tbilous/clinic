class UsersController < ApplicationController
  # before_action :signed_in_user, only: [:edit, :update, :update, :destroy]
  # before_action :correct_user,   only: [:edit, :update]
  # before_action :admin_user,     only: :destroy
  before_action :authenticate_user!, only: [ :edit, :show, :update, :index, :destroy
   ]
  before_action :current_user_admin, only:  :index 

  require 'will_paginate'
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    if current_user_admin
      @users = User.paginate(:page => params[:page], :per_page => 15).order('created_at DESC')
    else
      redirect_to root_path
    end
  end

  def edit
     @user = User.find(params[:id])
  end

  def update
  end

  def create

  end

  def destroy
    if User.find(params[:id]) == current_user
      redirect_to users_url
      flash[:error] = t('edit.delete_active')
    else
      User.find(params[:id]).destroy
      flash[:success] = t('edit.delete_succes')
      redirect_to users_url
    end
  end


  private

    # def user_params
    #   params.require(:user).permit(:email, :password, :password_confirmation)
    # end
    def current_user_admin
      current_user.admin?
    end


end
