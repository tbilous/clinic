class AnthropometriesController < ApplicationController
    include Devise::Controllers::Helpers
    # helper_method :current_user
    before_action :authenticate_user!
    before_action :require_permission, only: [:destroy]

    # def new
    #   @anthropometry = current_user && active_patient && current_user.anthropometries.new
    # end

    def index
        @anthropometry = current_user &&  current_patient.anthropometries.all
    end


    def create
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
        @anthropometry = Anthropometry.find(params[:id])
        @state_before = @anthropometry.character_id
        @anthropometry.destroy if @anthropometry.present?
        flash[:success] = t('activerecord.successful.messages.anthropometry.deleted')
        redirect_to character_path(@state_before)
    end


    def current_patient
        return unless current_user[:patient]
        @current_patient ||= Character.find(current_user.patient)
    end

    def anthropometry_user
      Anthropometry.find_by_id(params[:id]).user_id
    end


    private
        def anthropometries_params
            params.require(:anthropometry).permit(:character_id, :user_id, :date, :comment, :weight, :height, :chest, :cranium)
        end

        def require_permission
            # puts ">>>>>>>>>>>>>>> #{anthropometry_user.inspect}"
            redirect_to root_path if current_user.id != anthropometry_user
            # redirect_to root_path if current_user != user.id
        end
end
