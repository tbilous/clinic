class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      @characters = current_user.characters.all
    end
  end
 
  def about
  end
end
