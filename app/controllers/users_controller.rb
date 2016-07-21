class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end
  
  def index
    # User.paginate(page: params[:page])
    # @users = User.paginate(page: params[:page])
    # @users = User.all
  end
  
  def create
    
  end
  private

end
