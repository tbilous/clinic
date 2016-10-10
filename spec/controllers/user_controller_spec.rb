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
