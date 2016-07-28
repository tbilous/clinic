require 'rails_helper'
describe User do

  # user = FactoryGirl.build(:user)
  user = FactoryGirl.create(:user)
  
  # let (:title) { t(:site_name) + ' ' + t(:page_user) }
  # let(:title)    { "Clinic User\'s Profile" }
  

  it "should have a current_user" do
      # login_as(user, :scope => :user)
      login_as(user, :scope => :user, :run_callbacks => false)
      # visit current_user
      # page.should have_content user.name
  end
  # # it "should have a current_user" do
  # #   login_user
  # #   # note the fact that you should remove the "validate_session" parameter if this was a scaffold-generated controller
  # #   # expect(subject.current_user).to_not eq(nil)
  # # end

  # # it "should get index" do
  # #   login_user
  # #   # Note, rails 3.x scaffolding may add lines like get :index, {}, valid_session
  # #   # the valid_session overrides the devise login. Remove the valid_session from your specs
  # #   # get 'index'
  # #   # response.should be_success
  # # end
  # require 'spec_helper'
  
  # describe "Spec for Sign Up" do     
  #   it "should create new user account" do     
  #     visit new_user_registration_path    
  #     fill_in 'name', :with => user.name    
  #     fill_in 'email', :with => user.email    
  #     fill_in 'password', :with => user.password    
  #     fill_in 'password_confirmation', :with => user.password   
  #     click_button 'Sign up'    
  #     expect(page).to have_content "Welcome! You have signed up successfully."    
  #   end    
  # end

end