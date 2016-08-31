class AnthropometriesController < ApplicationController
    include Devise::Controllers::Helpers
    # helper_method :current_user
    before_action :authenticate_user!
    before_action :require_permission, only: [:edit, :show, :update, :destroy]
    before_action :active_patient, only: [:new, :create, :destroy]

    def new
      @anthropometry = current_user && active_patient && current_user.anthropometries.new
    end

    def index
        @anthropometry = current_user && active_patient && current_user.anthropometries.all
    end

    def show
        @anthropometry = current_user && active_patient && current_user.anthropometries.find(params[:id])
    end

    def create
        @anthropometry = current_user.anthropometries.build(anthropometries_params)
        if @anthropometry.save
            flash[:success] = t('activerecord.successful.messages.character.created')
            redirect_to root_path
        else
            # render "new"
            redirect_to root_path
            # redirect_to current_user.characters.new
        end
    end

    def destroy
        @anthropometry = current_user.anthropometries.find(params[:id])
        @anthropometry.destroy if @anthropometry.present?
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
        params.require(:anthropometry).permit(:user_id, :character_id, :date, :comment, :weight, :height, :chest, :cranium)
    end

    def require_permission
        redirect_to root_path if current_user != Character.find(params[:id]).user
    end
end
