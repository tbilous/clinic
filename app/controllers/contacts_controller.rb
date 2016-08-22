class ContactsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :require_permission, only: [:edit, :show, :update, :destroy]
  
  def new
    @contact = current_user && current_user.contacts.new
  end
  
  def index 
    if current_user.contacts.count != 0
      @contacts = current_user && current_user.contacts.all
    else
      redirect_to url_for( :action => :new)
    end
  end
    
  def show
    @contact = current_user && current_user.contacts.find(params[:id])
  end
  
  def create
    @contact = current_user.contacts.build(contacts_params)
    if @contact.save
      flash[:success] = t('activerecord.successful.messages.contact.created')
      redirect_to contacts_path
    else
      # render 'new'
      render "new"
    end
  end

  def edit
     @contact = current_user.contacts.find(params[:id])
  end
  
  def update
    @contact = current_user.contacts.find(params[:id])
    if @contact.update_attributes(contacts_params)
      flash[:success] = t("activerecord.successful.messages.contact.updated")
      render 'show'
    else
      render 'edit'
    end
  end
  
  def destroy
    @contact = current_user.contacts.find(params[:id])
    @contact.destroy if @contact.present?
    flash[:success] = t('activerecord.successful.messages.contact.deleted')
    redirect_to root_path
  end
  
  private
    def contacts_params
      params.require(:contact).permit(:name, :comment, :address, :phone, :email, :photo, :latitude, :longitude)
    end


    def require_permission
      # if current_user.contacts.count != 0
        if current_user != Contact.find(params[:id]).user
          redirect_to root_path
        end
      # else
        # flash[:error] = "List empty"
      # end
    end
end
