require 'rails_helper'

RSpec.describe 'ContactPage', type: :view do
  subject { page }
  include Devise::Test::ControllerHelpers
  before :each do
    @request.env['devise.mapping'] = Devise.mappings[:admin]
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @admin = FactoryGirl.create :admin
    @user = FactoryGirl.create :user
    # @character = FactoryGirl.create(:character, user: @user)
    # sign_in @admin
  end

  describe 'if have contacts' do
    before do
      login(@user)
    end
    let!(:contact) { FactoryGirl.create(:contact, user: @user) }
    describe 'should have contacts' do
      before do
        click_link( t(:contacts), href: contacts_path)
      end
      it { expect(page).to have_content contact.name }
      it { expect(page).to have_link( '', href: new_contact_path)}
      it { expect(page).to have_link( '', href: contact_path(contact.id))}
      describe 'link to view contact' do
        before do
          click_link( '', href: contact_path(contact.id))
        end
        it { expect(page).to have_content contact.name }
        it { expect(page).to have_link( '', href: edit_contact_path(contact.id))}
        describe 'edit contact' do
          before do
            click_link( '', href: edit_contact_path(contact.id))
          end
          it { should have_selector('h1', text: contact.name) }
        end
      end
      describe 'link to new contact' do
        before { click_link( '', href: new_contact_path) }
        it { should have_selector('h1', text: t('page.contact.new')) }
      end
    end
  end

  describe 'if not have contacts' do
    before do
      login(@user)
      click_link( t(:contacts), href: contacts_path)
    end
    it { should have_selector('h1', text: t('page.contact.new')) }
  end
end
