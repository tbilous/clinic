require 'rails_helper'

RSpec.describe User, type: :model do

  # user = FactoryGirl.create(:user)
  
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  
  describe "check profile" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      login_as user, scope: :user
      visit user_path(user)
    end
    it "should allow_not user access" do
      expect(page).to_not have_link('Users', href: users_path)
    end
    it "should have user name" do
      expect(page).to have_content user.name
    end
  end
  describe "check access" do
    let(:admin) { FactoryGirl.create(:admin) }
    before do
      login_as admin, scope: :user
      visit user_path(admin)
    end
    it "should allow admin access" do
      expect(page).to have_link('Users', href: users_path)
    end
    it "should have admin name" do
      expect(page).to have_content admin.name
    end
  end
  
  describe "with valid information" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      fill_in "Email",    with: user.email.upcase
      fill_in "Password", with: user.password
      click_button "Sign in"
    end
  
    it { should have_title(user.name) }
    it { should have_link('Users',       href: users_path) }
    it { should have_link('Profile',     href: user_path(user)) }
    it { should have_link('Sign out',    href: signout_path) }
    it { should have_link('Settings',    href: edit_user_path(user)) }
    it { should_not have_link('Sign in', href: signin_path) }
    describe "followed by signout" do
      before { click_link "Sign out" }
      it { should have_link('Sign in') }
    end
    describe "profile page" do
      let(:user) { FactoryGirl.create(:user) }
      before { visit user_path(user) }
    
      it { should have_content(user.name) }
      it { should have_title(user.name) }
    end
  end
  # it "should have a current_user" do
  #     login_as(user, :scope => :user)
  #     visit user_root_path(user)
  #     # page.should have_content user.name
  #     # page.should have_title(title) 
  # end


  
  # TODO! make test i18
  # <span class="translation_missing" title="translation missing: uk.users.passwords.edit.confirm_new_password">Confirm New Password</span>
  
end
