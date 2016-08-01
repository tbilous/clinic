require 'rails_helper'

  describe "Spec for Sign Up" do  
  before(:all) do
     Capybara.current_driver = :poltergeist
  end
    before { visit new_user_registration_path }

    it { expect(page).to have_title t(:sign_up) }

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
    	  expect(page).to_not have_css('.alert-error')
    	  expect(page).to_not have_css('.alert-warning')
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
  describe "blocked unauthorized access" do
    let(:user) { FactoryGirl.create(:user) }
    it "edit" do 
      visit edit_user_path(user)
      expect(page).to_not have_content user.name 
      expect(page).to have_content t('sign_in')
    end
    it "show" do 
      visit user_path(user)
      expect(page).to_not have_content user.name 
      expect(page).to have_content t('sign_in')
    end
    it "index" do 
      visit users_path
      expect(page).to_not have_content t('page.user.index')
      expect(page).to have_content t('sign_in')
    end
  end
  describe "Index page" do
    describe "admim should list all users" do
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }
      let(:admin) { FactoryGirl.create(:admin) }
      before do 
        login_as admin, scope: :user
        visit users_path
      end
      it { expect(page).to have_content t('page.user.index') }
      it { expect(page).to have_selector('div.pagination') }
      it { expect(page).to have_link t('edit.delete') }
      it "should table each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('td', text: user.name, between: 1..15)
        end
      end
      describe "delete user", :js => true do
        before { click_link( t('edit.delete'), match: :first  ) }
         it { expect(page).to have_css('.modal.in') }
        it { puts page.html }
        # it { expect(page).to have_css 'dev.modal-body' }
      end
    end
    # describe "delete admin" do
    #   let(:admin) { FactoryGirl.create(:admin) }
    #   before do 
    #     login_as admin, scope: :user
    #     visit users_path
    #   end
    #   click_link( t('edit.delete'), match: :first )
    #   it { expect(page).to have_content t('page.user.index') }
    # end
    describe "ordinary users shoul not have access index" do 
      before do 
        login_as user, scope: :user
        visit users_path
        it { expect(page).to_not have_content t('page.user.index') }
        it { expect(page).to have_title t('page_home') }
      end
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
