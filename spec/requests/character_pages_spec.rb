require 'rails_helper'

RSpec.describe "CharacterPages", type: :view do
  subject { page }
  include Devise::Test::ControllerHelpers
  before :each do
    @request.env['devise.mapping'] = Devise.mappings[:admin]
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @admin = FactoryGirl.create :admin
    @user = FactoryGirl.create :user
    # sign_in @admin
  end

  describe 'in the Character pages without characters' do
    before { login(@user) }
    it 'should not view empty list characters' do
      expect(page).to_not have_css('.home-characters-list')
      expect(page).to have_link(t('patient.create'), href: new_character_path)
    end
    describe 'create character' do
      before { click_on(t('patient.create')) }
      it { expect(page).to have_content(t('page.character.new')) }
      describe 'wrong validations' do
        before { (find('.btn-sent').click) }
        it { expect(page).to have_css('.alert.alert-danger') }
        it { expect(response).to render_template('new') }
      end
      describe 'fill in form' do
        let(:character) { FactoryGirl.create(:character, user: @user) }
        before do
          fill_in 'character_name', with: character.name
          fill_in 'character_comment', with: character.comment
          find('#character_birthday_1i').select(character.birthday.year.to_s)
          find('#character_birthday_2i').select(Date::MONTHNAMES[character.birthday.month])
          find('#character_birthday_3i').select(character.birthday.day.to_s)
          find('#character_sex_true').set(true)
        end
        it { expect { (find('.btn-sent').click) }.to change(Character, :count).by(1) }
        describe 'check result' do
          before { (find('.btn-sent').click) }
          # it { expect(page).to have_css('.home-characters-list') }
          # it { expect(page).to have_content character.name }
          # it { expect(page).to have_content character.comment }
          # it { expect(page).to have_css '.glyphicon-pencil' }
        end
      end
    end
  end
  describe 'in the Character pages with characters' do
    let!(:character) { FactoryGirl.create(:character, user: @user) }
    before do
      login_as @user, scope: :user
      visit users_path
    end
    it 'should view non-empty list characters' do
      expect(page).to have_css('.home-characters-list')
      expect(page).to have_link(t('patient.create'), href: new_character_path)
      expect(page).to have_link('', href: edit_character_path(character))
    end
    describe 'edit character' do
      before { click_link('', href: edit_character_path(character)) }
      it { expect(page).to have_content character.name }
      it { expect(page).to have_title t('page.character.edit') }
    end
  end
  describe 'Edit character' do
    let!(:character) { FactoryGirl.create(:character, user: @user) }
    before do
      login(@user)
      page.click_link('', :href => edit_character_path(character))
    end
    describe 'should have content' do
      it { expect(page).to have_content character.name }
      it { expect(page).to have_title t('page.character.edit') }
    end
    it :js => true do
      expect { click_link t('edit.delete') }.to change(Character, :count).by(-1)
      expect(page).to have_css('.alert-success')
    end
    it { expect(page).to have_content character.name }
  end
end
