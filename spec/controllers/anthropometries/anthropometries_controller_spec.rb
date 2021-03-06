require 'rails_helper'

RSpec.describe AnthropometriesController, type: :controller do
  before :each do
    @request.env['devise.mapping'] = Devise.mappings[:admin]
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @admin = FactoryGirl.create :admin
    @user = FactoryGirl.create :user
    @character = FactoryGirl.create(:character, user: @admin)
  end

  describe 'for non-signed-in users' do
    describe 'submitting to the destroy action' do
      let!(:adata) { FactoryGirl.create(:adata, user_id: @character.user_id, character: @character) }
      before { delete :destroy, id: adata.id }
      specify { expect(response).to redirect_to(new_user_session_path) }
    end
  end
  describe 'for signed-in non owner user' do
    before do
      sign_in @user
    end
    describe 'should not to destroy anthropometry' do
      let!(:adata) { FactoryGirl.create(:adata, user_id: @character.user_id, character: @character) }
      before { delete :destroy, id: adata.id }
      specify { expect(response).to redirect_to(root_path) }
    end
  end

  describe 'for signed-in' do
    describe 'and owner users' do
      before do
        sign_in @admin
      end
      describe 'DELETE destroy' do
        let!(:anthropometry) { FactoryGirl.create(:adata, user_id: @character.user_id, character: @character) }
        it { expect { delete :destroy, id: anthropometry.id }.to change(Anthropometry, :count).by(-1) }
      end
      describe 'CREATE' do
        before do
          @admin.update_attribute(:patient, @character.id)
        end
        it 'creates anthropometry' do
          adata_params = FactoryGirl.attributes_for(:adata, user_id: @admin.id, character: @character)
          expect { post :create, :anthropometry => adata_params }.to change(Anthropometry, :count).by(1)
        end
      end
    end
  end
end
