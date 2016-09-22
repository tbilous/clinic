require 'rails_helper'

RSpec.describe 'PharmPage', type: :view do
  subject { page }
  include Devise::Test::ControllerHelpers
  before :each do
    @request.env['devise.mapping'] = Devise.mappings[:admin]
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @admin = FactoryGirl.create :admin
    @user = FactoryGirl.create :user
    @pharm_type = FactoryGirl.create(:pharm_type, user: @user)
    @pharm_owner = FactoryGirl.create(:pharm_owner, user: @user)
  end
  describe 'if have pharmacies' do
    helper_method :current_user
    before do
      login(@user)
    end
    describe 'should have pharms' do
      let!(:pharm) { FactoryGirl.create(:pharm, user: @user, pharm_owner: @pharm_owner, pharm_type: @pharm_type) }
      before do
        click_link( t('pharmacy'), href: pharms_path)
      end
      it { expect(page).to have_content pharm.name }
      it { expect(page).to have_link( '', href: new_pharm_path)}
      it { expect(page).to have_link( '', href: pharm_path(pharm.id))}
      describe 'link to view pharm' do
        before do
          click_link( '', href: pharm_path(pharm.id))
        end
        it { expect(page).to have_content pharm.name }
        it { expect(page).to have_link( '', href: edit_pharm_path(pharm.id))}
        describe 'edit pharm' do
          before do
            click_link( '', href: edit_pharm_path(pharm.id))
          end
          it { should have_selector('h1', text: pharm.name) }
        end
      end
      describe 'link to new pharm' do
        before { click_link( '', href: new_pharm_path) }
        it { should have_selector('h1', text: t('page.pharm.new')) }
      end
    end
  end

  describe 'if not have pharmacy' do
    before do
      login(@user)
      click_link( t('pharmacy'), href: pharms_path)
    end
    it { should have_selector('h1', text: t('page.pharm.new')) }
  end
end
