class CharactersController < ApplicationController
  include Devise::Controllers::Helpers
  # helper_method :current_user
  before_action :authenticate_user!
  before_action :require_permission, only: [:edit, :show, :update, :destroy, :activate]

  def new
    @character = current_user && current_user.characters.new
  end

  # def index
  #   @characters = current_user && current_user.characters.all
  # end

  def show
    @character = current_user && current_user.characters.find(params[:id])
    @characters = Character.all.paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
    @anthropometry = @character.anthropometries.build
    # @anthropometries = @character.anthropometries.all
    @anthropometries = @character.anthropometries.all.paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
  end

  def create
    @character = current_user.characters.build(character_params)
    if @character.save
      flash[:success] = t('activerecord.successful.messages.character.created')
      activate_character(@character.id)
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
     @character = current_user.characters.find(params[:id])
  end

  def update
    @character = current_user.characters.find(params[:id])
    if @character.update_attributes(character_params)
      flash[:success] = t('activerecord.successful.messages.character.created')
      redirect_to root_path
    else
      render 'edit'
    end
  end
  def activate_character(id)
    current_user.update_attribute(:patient, id)
  end


  def activate
    # puts ">>>>>>>>>>>>>>> #{params[:id].inspect}"
    @character = current_user.characters.find(params[:id])
    if current_user.patient != @character.id
      current_user.update_attribute(:patient, @character.id)
       flash[:success] = @character.name
    end
      redirect_to root_path
  end

  def destroy
    @character = current_user.characters.find(params[:id])
    @character.destroy if @character.present?
    flash[:success] = t('activerecord.successful.messages.character.deleted')
    redirect_to root_path
  end

  private
    def character_params
      params.require(:character).permit(:name, :comment, :sex, :birthday,  :used)
    end


    def require_permission
      if current_user != Character.find(params[:id]).user
        redirect_to root_path
      end
    end
end
