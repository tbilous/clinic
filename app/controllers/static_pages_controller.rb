# :nodoc: all
class StaticPagesController < ApplicationController
  def home
    @characters = current_user.characters.all if user_signed_in?
  end

  def about
  end
end
