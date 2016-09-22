class PharmOwnersController < ApplicationController
  def create
    @pharm_owner = current_user.pharm_owners.build(pharms_params)
    if @pharm.save
      flash[:success] = t('activerecord.successful.messages.pharm.created')
      render :text => 'OK'
    else
      render 'pharms/new'
    end
  end

  def destroy
  end
end
