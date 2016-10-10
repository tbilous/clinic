require 'rails_helper'

RSpec.describe PharmsController, type: :controller do
  before :each do
    @request.env['devise.mapping'] = Devise.mappings[:admin]
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @admin = FactoryGirl.create :admin
    @user = FactoryGirl.create :user
    @pharm_type = FactoryGirl.create(:pharm_type, user: @user)
    @pharm_owner = FactoryGirl.create(:pharm_owner, user: @user)
  end

  describe 'for non-signed-in users' do
    describe 'submitting to the destroy action' do
      let!(:pharm_data) { FactoryGirl.create(:pharm, user: @user, pharm_owner: @pharm_owner, pharm_type: @pharm_type) }
      before { delete :destroy, id: pharm_data.id }
      specify { expect(response).to redirect_to(new_user_session_path) }
    end
  end
  describe 'for signed-in non owner user' do
    before do
      sign_in @admin
    end
    describe 'should not to destroy pharm' do
      let!(:pharm_data) { FactoryGirl.create(:pharm, user: @user, pharm_owner: @pharm_owner, pharm_type: @pharm_type) }
      before { delete :destroy, id: pharm_data.id }
      specify { expect(response).to redirect_to(root_path) }
    end
  end

  describe 'for signed-in' do
    describe 'and owner users' do
      before do
        sign_in @admin
      end
      describe 'DELETE destroy' do
        let!(:pharm) { FactoryGirl.create(:pharm, user: @admin, pharm_owner: @pharm_owner, pharm_type: @pharm_type) }
        it { expect { delete :destroy, id: pharm.id }.to change(Pharm, :count).by(-1) }
      end
      describe 'CREATE' do
        it 'creates pharm' do
          pharm_params = FactoryGirl.attributes_for(:pharm,
                                                    user: @admin,
                                                    pharm_owner_id: @pharm_owner.id,
                                                    pharm_type_id: @pharm_type.id)
          expect { post :create, pharm: pharm_params }.to change(Pharm, :count).by(1)
        end
      end
    end
  end
end
