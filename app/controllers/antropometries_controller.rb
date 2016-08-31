class AntropometriesController < ApplicationController
  include Devise::Controllers::Helpers
  # helper_method :current_user
  before_action :authenticate_user!
  before_action :require_permission, only: [:edit, :show, :update, :destroy]
  before_action :active_patient, only: [:new, :create, :destroy]

  # def new
  #   @antropos = current_user && active_patient && current_user.anthropometries.new
  # end

  def index
    @antropos = current_user && active_patient && current_user.anthropometries.all
  end

  # def show
  #   @antropos = current_user && active_patient && current_user.anthropometries.find(params[:id])
  # end

  def create
    @antropos = current_user.anthropometries.build(anthropometries_params)
    if @antropos.save
      flash[:success] = t('activerecord.successful.messages.character.created')
      redirect_to root_path
    else
      # render "new"
      redirect_to root_path
      # redirect_to current_user.characters.new
    end
  end


  def destroy
    @antropos = current_user.anthropometries.find(params[:id])
    @antropos.destroy if @antropos.present?
    flash[:success] = t('activerecord.successful.messages.character.deleted')
    redirect_to root_path
  end

  def active_patient
    current_user.patient?
  end
  def current_patient
    return unless current_user[:patient]
    @current_patient ||= Character.find(current_user.patient)
  end
  private
    def anthropometries_params
      params.require(:anthropometry).permit(:date, :character_id, :weight, :height, :chest,  :cranium)
    end


    def require_permission
      if current_user != Character.find(params[:id]).user
        redirect_to root_path
      end
    end
end
