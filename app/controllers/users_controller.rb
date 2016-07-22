class UsersController < ApplicationController
  # before_action :signed_in_user, only: [:edit, :update, :update, :destroy]
  # before_action :correct_user,   only: [:edit, :update]
  # before_action :admin_user,     only: :destroy
  require 'will_paginate'
  def new
    @user = User.new
  end

  def show
    @user = current_user
  end
  
  def index

  # @user = User.find_by_name(params[:id])

    # User.paginate(page: params[:page])
    @users = User.paginate(:page => params[:page], :per_page => 15).order('created_at DESC')
    # @users = User.all
  end
  
  def edit
     @user = current_user
  end
  
  def update
  end
  
  def create
    
  end
  
  
  private

    # def user_params
    #   params.require(:user).permit(:email, :password, :password_confirmation)
    # end

end
