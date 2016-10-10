class PharmTypesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_permission, only: [:destroy]
  layout false

  def index
    render json: current_user_pharm_types
  end

  def new
    @pharm_type = current_user.pharm_types.build(secure_params)
  end

  def create
    @pharm_type = current_user.pharm_types.build(secure_params)
    if @pharm_type.save
      flash[:success] = t('activerecord.successful.messages.pharm.created')
      @pharm_type = current_user.pharm_types.build({})
      render 'pharm_types/new.html.slim'
    else
      render :new
    end
  end

  def destroy
    @pharm_type = current_user.pharm_types.find(params[:id])
    @pharm_type.destroy if @pharm_type.present?
    flash[:success] = t('activerecord.successful.messages.pharm.deleted')
    render 'index'
  end

  def current_user_pharm_types
    trash = %w(created_at updated_at user_id)
    @pharm_owners ||=
      PharmType.where(user_id: current_user.try(:id)).order('id DESC')
               .map { |po| po.attributes.except(*trash) }
  end
  helper_method :current_user_pharm_types

  private

  def secure_params
    params.require(:pharm_type).permit(:name, :comment, :slug)
  end

  def require_permission
    redirect_to root_path if current_user != PharmType.find(params[:id]).user
  end
end
