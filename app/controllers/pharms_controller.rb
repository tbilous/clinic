class PharmsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_permission, only: [:edit, :show, :update, :destroy]

  def new
    @pharm = current_user && current_user.pharms.new
    @pharm_owner = current_user.pharm_owners.build
    @pharm_type = current_user.pharm_types.build
  end

  def create
    @pharm = current_user.pharms.build(pharms_params)
    if @pharm.save
      flash[:success] = t('activerecord.successful.messages.pharm.created')
      render 'new'
    else
      render 'new'
    end
  end

  def index
    if current_user.pharms.count != 0
      if params[:search]
        @pharms = current_user && Pharm.search(params[:search]).paginate(:page => params[:page]).order('name DESC')
        # @users = User
      else
        @pharms = current_user && current_user.pharms.all.paginate(:page => params[:page]).order('name DESC')
      end
    else
      redirect_to url_for(:action => :new)
    end
  end

  def show
    @pharm = current_user && current_user.pharms.find(params[:id])
  end

  def edit
    @pharm = current_user.pharms.find(params[:id])
  end

  def update
  end


  def destroy
    @pharm = current_user.pharms.find(params[:id])
    @pharm.destroy if @pharm.present?
    flash[:success] = t('activerecord.successful.messages.pharm.deleted')
    render 'index'
  end

  private
  def pharms_params
    params.require(:pharm).permit(:name, :comment, :attention, :dose, :volume, :pharm_type_id, :pharm_owner_id)
  end

  def require_permission
    if current_user != Pharm.find(params[:id]).user
      redirect_to root_path
    end
  end
end
