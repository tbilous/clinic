require 'rails_helper'

describe User do

  user = FactoryGirl.build(:user)
  # let (:title) { t(:site_name) + ' ' + t(:page_user) }
  let(:title)    { "Clinic User\'s Profile" }
  
  it { should respond_to(:name) }
  it { should respond_to(:email) }


  it "should have a current_user" do
      login_as(user, :scope => :user)
      visit user_root_path
      page.should have_content user.name
      page.should have_title(title) 
    end

  Warden.test_reset! 
  
end
