require 'rails_helper'

RSpec.describe PharmOwnersController, type: :controller do
  before :each do
    @request.env['devise.mapping'] = Devise.mappings[:admin]
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @admin = FactoryGirl.create :admin
    @user = FactoryGirl.create :user
  end

  describe 'for non-signed-in users' do
    describe 'submitting to the destroy action' do
      let!(:pharm_owner) { FactoryGirl.create(:pharm_owner, user: @user) }
      before { delete :destroy, id: pharm_owner.id }
      specify { expect(response).to redirect_to(new_user_session_path) }
    end
  end
  describe 'for signed-in non owner user' do
    before do
      sign_in @admin
    end
    describe 'should not to destroy pharm' do
      let!(:pharm_owner) { FactoryGirl.create(:pharm_owner, user: @user) }
      before { delete :destroy, id: pharm_owner.id }
      specify { expect(response).to redirect_to(root_path) }
    end
  end

  describe 'for signed-in' do
    before do
      sign_in @admin
    end
    describe 'DELETE destroy' do
      let!(:pharm_owner) { FactoryGirl.create(:pharm_owner, user: @admin) }
      it { expect { delete :destroy, id: pharm_owner.id }.to change(PharmOwner, :count).by(-1) }
    end
    describe 'CREATE' do
      it 'creates pharm' do
        pharm_params = FactoryGirl.attributes_for(:pharm_owner, user: @admin.id)
        # binding.pry
        expect { post :create, :pharm_owner => pharm_params }.to change(PharmOwner, :count).by(1)
      end
    end
  end
end