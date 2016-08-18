module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      # sign_in FactoryGirl.create(:admin)
      admin = FactoryGirl.create(:admin)
      sign_in :user, admin # sign_in(scope, resource)
    end
  end

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(:user)
      sign_in user
    end
  end
  def login(u)
    visit new_user_session_path
  	fill_in 'user_email', with: u.email
  	fill_in 'user_password', with: u.password
  	click_button t(:sign_in)
  end

end