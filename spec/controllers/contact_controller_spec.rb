require 'rails_helper'

RSpec.describe ContactsController, type: :controller do
  before :each do
    @request.env['devise.mapping'] = Devise.mappings[:admin]
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @admin = FactoryGirl.create :admin
    @user = FactoryGirl.create :user
    # sign_in @admin
  end
  # render_views

  describe 'for non-signed-in users' do
    describe 'submitting to the create action' do
      before do
        post 'new'
      end
      specify { expect(response).to redirect_to(new_user_session_path) }
    end

    describe 'submitting to the destroy action' do
      let(:contact) { FactoryGirl.create(:contact, user: @admin) }
      before { delete :destroy, id: contact.id }
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
    describe 'GET index empty' do
      it 'renders the index template' do
        get :index
        expect(response).to redirect_to(new_contact_path)
      end
    end

    describe 'and owner users' do
      let!(:contact) { FactoryGirl.create(:contact, user: @admin) }

      describe 'PUT update' do
        let(:attr) do
          { name: 'new name', comment: 'new comment' }
        end
        before(:each) do
          put :update, id: contact.id, user: @admin.id, contact: attr
          contact.reload
        end
        it { expect(response).to render_template(:show) }
        it { expect(contact.name).to eql attr[:name] }
        it { expect(contact.comment).to eql attr[:comment] }
      end

      describe 'GET index' do
        it 'renders the index template' do
          get :index
          expect(response).to render_template('index')
        end
      end

      describe 'DELETE destroy' do
        it do
          expect do
          delete :destroy, id: contact.id
        end.to change { Contact.count }.by(-1) end
      end

      describe 'GET show' do
        before do
          get :show, id: contact.id
        end
        it { expect(response).to render_template(:show) }
      end
    end
    describe 'and non-owner users' do
      let!(:contact) { FactoryGirl.create(:contact, user: @user) }

      describe 'GET show' do
        before do
          get :show, id: contact.id, user: @user.id
        end
        it { expect(response).to_not render_template(:show) }
        it { expect(response).to redirect_to(root_path) }
      end

      describe 'PUT update' do
        let(:attr) do
          { name: 'new name', comment: 'new comment' }
        end
        before(:each) do
          put :update, id: contact.id, user: @user.id, contact: attr
          contact.reload
        end
        it { expect(response).to redirect_to(root_path) }
        it { expect(contact.name).to_not eql attr[:name] }
        it { expect(contact.comment).to_not eql attr[:comment] }
      end

      describe 'DELETE destroy' do
        it do
          expect { delete :destroy, id: contact.id }.to_not change { Contact.count }
        end
      end
    end
  end
end
