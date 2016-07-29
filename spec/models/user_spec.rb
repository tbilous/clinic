require 'rails_helper'

RSpec.describe User, type: :model do

  # user = FactoryGirl.create(:user)
  
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  
  describe "Spec for Sign Up" do  
    before do 
      visit new_user_registration_path 
    end
    describe "should have title" do
      it { expect(page).to have_title t(:sign_up) }
    end
    describe "Create user" do
    let(:user) { FactoryGirl.create(:user) }
    it "should create new user account" do     
      #puts user.email  
      	fill_in 'user_name', with: user.name
      	fill_in 'user_email', with: "lksacldsak@dhvbsjd.com"
      	fill_in 'user_password', with: user.password
      	fill_in 'user_password_confirmation', with: user.password  
      	click_button t(:sign_up)
    	  expect(page).to have_content t('users.registrations.signed_up')   
    	  expect(page).to_not have_css('.alert')
    	  expect(page).to_not have_link(t(:sign_in), href: new_user_session_path)
    	  expect(page).to_not have_link(t(:sign_up), href: new_user_registration_path )
    	  expect(page).to have_link(t(:sign_out), href: destroy_user_session_path)
    	   #puts page.find('.alert').text
      end  

    end
  end
  
  describe "Check user profile" do
    describe "check user page" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        login_as user, scope: :user
        visit user_path(user)
        # puts page.body
      end
  
      it { expect(page).to have_title t(:page_user) }
      it { expect(page).to have_content user.name }
      it { expect(page).to_not have_link('Users', href: users_path) }
      it { expect(page).to_not have_link t(:sign_in) }
     
      it "Check sign out" do
        click_link t(:sign_out) 
        expect(page).to have_link t(:sign_in)
      end
    end

    describe "check admin page" do
      let(:user) { FactoryGirl.create(:admin) }
      before do
        login_as user, scope: :user
        visit user_path(user)
      end
      it { expect(page).to have_title t(:page_user) }
      it { expect(page).to have_content user.name }
      it { expect(page).to have_link('Users', href: users_path) }
      it { expect(page).to_not have_link t(:sign_in) }
    end
  end
  
  describe "Check edit user profile" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      login_as user, scope: :user
      visit edit_user_path(user)
      # puts page.body
    end
    it { expect(page).to have_title t(:page_user_edit)}
  end
  describe "Check unauthorized access" do
    let(:user) { FactoryGirl.create(:user) }

    it "edit" do 
      visit edit_user_path(user)
      expect(page).to_not have_content user.name 
    end
    it "show" do 
      visit user_path(user)
      expect(page).to_not have_content user.name 
    end
    it "index" do 
      visit users_path
      expect(page).to_not have_content t('page.user.index')
    end
  end
  
  # describe "with valid information" do
  #   let(:user) { FactoryGirl.create(:user) }
  #   before do
  #     fill_in "Email",    with: user.email.upcase
  #     fill_in "Password", with: user.password
  #     click_button "Sign in"
  #   end
  
  #   it { should have_title(user.name) }
  #   it { should have_link('Users',       href: users_path) }
  #   it { should have_link('Profile',     href: user_path(user)) }
  #   it { should have_link('Sign out',    href: signout_path) }
  #   it { should have_link('Settings',    href: edit_user_path(user)) }
  #   it { should_not have_link('Sign in', href: signin_path) }
  #   describe "followed by signout" do
  #     before { click_link "Sign out" }
  #     it { should have_link('Sign in') }
  #   end
  #   describe "profile page" do
  #     let(:user) { FactoryGirl.create(:user) }
  #     before { visit user_path(user) }
    
  #     it { should have_content(user.name) }
  #     it { should have_title(user.name) }
  #   end
  # end


  
  # TODO! make test i18
end
