class UsersControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers 
  include Devise::Test::IntegrationHelpers
  def setup
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    sign_in FactoryGirl.create(:admin)
  end
  
  # describe UsersController do

  
  #   it "should have a current_user" do
  #     login_admin
  #     # note the fact that you should remove the "validate_session" parameter if this was a scaffold-generated controller
  #     expect(subject.current_user).to_not eq(nil)
  #   end
  
  #   it "should get index" do
  #     login_admin
  #     # Note, rails 3.x scaffolding may add lines like get :index, {}, valid_session
  #     # the valid_session overrides the devise login. Remove the valid_session from your specs
  #     get 'index'
  #     response.should be_success
  #   end
  # end

end
