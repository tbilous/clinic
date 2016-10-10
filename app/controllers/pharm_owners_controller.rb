# :nodoc: all
class PharmOwnersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_permission, only: [:destroy]
  layout false

  def index
    render json: current_user_pharm_owners
  end

  def new
    @pharm_owner = current_user.pharm_owners.build(secure_params)
  end

  def create
    @pharm_owner = current_user.pharm_owners.build(secure_params)
    if @pharm_owner.save
      flash[:success] = t('activerecord.successful.messages.pharm.created')
      @pharm_owner = current_user.pharm_owners.build({})
      render 'new'
    else
      render 'pharms/index'
    end
  end

  def destroy
    @pharm_owner = current_user.pharm_owners.find(params[:id])
    @pharm_owner.destroy if @pharm_owner.present?
    flash[:success] = t('activerecord.successful.messages.pharm.deleted')
    render 'pharms/index'
  end

  def current_user_pharm_owners
    trash = %w(created_at updated_at user_id)
    @pharm_owners ||=
      PharmOwner.where(user_id: current_user.try(:id)).order('id DESC')
                .map { |po| po.attributes.except(*trash) }
  end
  helper_method :current_user_pharm_owners

  private

  def secure_params
    params.fetch(:pharm_owner, {}).permit(:name, :comment)
  end

  def require_permission
    redirect_to root_path if current_user != PharmOwner.find(params[:id]).user
  end
end
