class AnthropometriesController < ApplicationController
    include Devise::Controllers::Helpers
    # helper_method :current_user
    before_action :authenticate_user!
    before_action :require_permission, only: [:edit, :show, :destroy]
    # before_action :active_patient, only: [:new, :destroy]

    # def new
    #   @anthropometry = current_user && active_patient && current_user.anthropometries.new
    # end

    def index
        @anthropometry = current_user &&  current_patient.anthropometries.all
    end


    def create
        # puts ">>>>>>>>>>>>>>> #{params[:id].inspect}"

        @anthropometry = current_patient.anthropometries.build(anthropometries_params)
        @anthropometry.user_id = current_user.id if current_user
        if @anthropometry.save
            flash[:success] = t('activerecord.successful.messages.anthropometry.created')
            redirect_to character_path(@anthropometry.character_id)
        else
            redirect_to root_path
        end
    end

    def destroy
        @anthropometry = anthropometries.find(params[:id])
        @state_before = @anthropometry.character_id
        @anthropometry.destroy if @anthropometry.present?
        flash[:success] = t('activerecord.successful.messages.anthropometry.deleted')
        redirect_to character_path(@state_before)
    end


    def current_patient
        return unless current_user[:patient]
        @current_patient ||= Character.find(current_user.patient)
    end


    private
        def anthropometries_params
            params.require(:anthropometry).permit(:character_id, :user_id, :date, :comment, :weight, :height, :chest, :cranium)
        end

        def require_permission
            redirect_to root_path if current_user != Anthropometry.find(params[:id]).user_id
        end
end
