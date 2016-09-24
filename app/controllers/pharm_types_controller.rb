class PharmTypesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_permission, only: [:destroy]
  def index
    @pharm_types = PharmType.all
  end
  def create
    @pharm_type = current_user.pharm_types.build(secure_params)
    if @pharm_type.save
      flash[:success] = t('activerecord.successful.messages.pharm.created')
      redirect_to new_pharm_path
    else
      redirect_to new_pharm_path
    end
  end

  def destroy
    @pharm_type = current_user.pharm_types.find(params[:id])
    @pharm_type.destroy if @pharm_type.present?
    flash[:success] = t('activerecord.successful.messages.pharm.deleted')
    render 'index'
  end


  private
  def secure_params
    # TODO 'Та сама хуйня що з овнером'
    params.require(:pharm_type).permit(:name, :comment, :slug)
  end
  def require_permission
    if current_user != PharmType.find(params[:id]).user
      redirect_to root_path
    end
  end
end
