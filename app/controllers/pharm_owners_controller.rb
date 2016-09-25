class PharmOwnersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_permission, only: [:destroy]
  layout false

  def index
    render json: current_user_pharm_owners
  end

  def new
    @pharm_owner = current_user.pharm_owners.build(pharm_owner_params)
  end

  def create
    @pharm_owner = current_user.pharm_owners.build(pharm_owner_params)
    @pharm = current_user && current_user.pharms.new
    if @pharm_owner.save
      flash[:success] = t('activerecord.successful.messages.pharm.created')
      @pharm_owner = current_user.pharm_owners.build({})
      render :new
    else
      render :new
    end
  end

  def destroy
    @pharm_owner = current_user.pharm_owners.find(params[:id])
    @pharm_owner.destroy if @pharm_owner.present?
    flash[:success] = t('activerecord.successful.messages.pharm.deleted')
    render 'index'
  end

  def current_user_pharm_owners
    trash = ["created_at", "updated_at", "user_id"]
    @pharm_owners ||=
      PharmOwner.where(user_id: current_user.try(:id))
                .map{ |po| po.attributes.except(*trash) }
  end
  helper_method :current_user_pharm_owners

  private

  def pharm_owner_params
    # TODO 'А хуй його знає що з ним'
    params.fetch(:pharm_owner, {}).permit(:name, :comment)
  end

  def require_permission
    if current_user != PharmOwner.find(params[:id]).user
      redirect_to root_path
    end
  end
end
