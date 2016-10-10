require 'rails_helper'

RSpec.describe CharactersController, type: :controller do
  before :each do
    @request.env['devise.mapping'] = Devise.mappings[:admin]
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @admin = FactoryGirl.create :admin
    @user = FactoryGirl.create :user
  end

  describe 'for non-signed-in users' do
    describe 'submitting to the create action' do
      before do
        post 'new'
      end
      specify { expect(response).to redirect_to(new_user_session_path) }
    end

    describe 'submitting to the destroy action' do
      let(:character) { FactoryGirl.create(:character, user: @admin) }
      before { delete :destroy, id: character.id }
      specify { expect(response).to redirect_to(new_user_session_path) }
    end
  end

  describe 'for signed-in' do
    before do
      sign_in @admin
    end

    describe 'POST new' do
      before do
        post 'new'
      end
      it { expect(response).to render_template(:new) }
      it { expect(response).to_not redirect_to(new_user_session_path) }
    end
    describe 'Create new' do
      it 'creates character' do
        character_params = FactoryGirl.attributes_for(:character)
        expect { post :create, character: character_params }.to change(Character, :count).by(1)
      end
    end

    describe 'and owner users' do
      let!(:character) { FactoryGirl.create(:character, user: @admin) }

      describe 'PUT update' do
        let(:attr) do
          { name: 'new name', comment: 'new comment' }
        end
        before(:each) do
          put :update, id: character.id, user: @admin.id, character: attr
          character.reload
        end
        it { expect(response).to redirect_to(root_path) }
        it { expect(character.name).to eql attr[:name] }
        it { expect(character.comment).to eql attr[:comment] }
      end

      it 'DELETE destroy' do
        expect { delete :destroy, id: character.id }.to change(Character, :count).by(-1)
      end

      describe 'GET show' do
        before do
          get :show, id: character.id
        end
        it { expect(response).to render_template(:show) }
      end
    end
    describe 'and non-owner users' do
      let!(:character) { FactoryGirl.create(:character, user: @user) }

      describe 'GET show' do
        before do
          get :show, id: character.id, user: @user.id
        end
        it { expect(response).to_not render_template(:show) }
        it { expect(response).to redirect_to(root_path) }
      end

      describe 'PUT update' do
        let(:attr) do
          { name: 'new name', comment: 'new comment' }
        end
        before(:each) do
          put :update, id: character.id, user: @user.id, character: attr
          character.reload
        end
        it { expect(response).to redirect_to(root_path) }
        it { expect(character.name).to_not eql attr[:name] }
        it { expect(character.comment).to_not eql attr[:comment] }
      end

      describe 'DELETE destroy' do
        it do
          # character
          expect { delete :destroy, id: character.id }.to_not change { Character.count }
        end
      end
    end
  end
end
