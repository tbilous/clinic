class PharmOwnersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_permission, only: [:destroy]
  def index
    @pharm_owners = PharmOwner.all
  end
  def create
    @pharm_owner = current_user.pharm_owners.build(pharm_owner_params)
    @pharm = current_user && current_user.pharms.new
    if @pharm_owner.save
      flash[:success] = t('activerecord.successful.messages.pharm.created')
      redirect_to new_pharm_path
    else
      redirect_to new_pharm_path
    end
  end

  def destroy
    @pharm_owner = current_user.pharm_owners.find(params[:id])
    @pharm_owner.destroy if @pharm_owner.present?
    flash[:success] = t('activerecord.successful.messages.pharm.deleted')
    render 'index'
  end


  private
  def pharm_owner_params
    # TODO 'А хуй його знає що з ним'
    params.require(:pharm_owner).permit(:name, :comment)
  end
  def require_permission
    if current_user != PharmOwner.find(params[:id]).user
      redirect_to root_path
    end
  end
end
