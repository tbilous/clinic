require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include Devise::Test::ControllerHelpers
  before :each do
      @request.env['devise.mapping'] = Devise.mappings[:admin]
      @request.env['devise.mapping'] = Devise.mappings[:user]
      @admin = FactoryGirl.create :admin
      @user = FactoryGirl.create :user
      # sign_in @admin
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
  describe 'signed user' do
    before do
      sign_in @admin
    end
    describe 'submitting to the destroy action' do
      let!(:character) { FactoryGirl.create(:character, user: @admin) }
      let!(:anthropometry) { FactoryGirl.create(:adata, user_id: @admin.id, character_id: character.id) }

      it { expect { delete :destroy, id: @user.id }.to change { User.count }.by(-1) }
    end
  end
end
