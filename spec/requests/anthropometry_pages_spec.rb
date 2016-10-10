require 'rails_helper'

RSpec.describe 'AnthropometryPage', type: :view do
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

  describe 'in the Character pages without characters' do
    before { login(@user) }
    let!(:character) { FactoryGirl.create(:character, user: @user) }
    describe 'should have character' do
      before do
        visit root_path
        Capybara.ignore_hidden_elements = false
        click_button 'Some Button'
        Capybara.ignore_hidden_elements = true
      end
      it { expect(page).to have_content character.name }
      it { expect(page).to have_link(character.name) }
    end
    describe 'visit Active Patient page' do
      # before { click_link('character.name') }
      before do
        visit root_path
        Capybara.ignore_hidden_elements = false
        click_button 'Some Button'
        Capybara.ignore_hidden_elements = true
        click_link(character.name, href: character_path(character.id))
      end
      describe 'create anthropometry' do
        let!(:anthropometry) { FactoryGirl.build(:adata, user_id: character.user_id, character_id: character.id) }
        before do
          # binding.pry
          # puts("\nWTF #{anthropometry.inspect}\n")
          find('#anthropometry_date_1i').select(DateTime.now.year.to_s)
          find('#anthropometry_date_2i').select(Date::MONTHNAMES[DateTime.now.month])
          find('#anthropometry_date_3i').select(DateTime.now.day.to_s)
          fill_in 'anthropometry_height', with: anthropometry.height
          fill_in 'anthropometry_weight', with: anthropometry.weight
          fill_in 'anthropometry_cranium', with: anthropometry.cranium
          fill_in 'anthropometry_chest', with: anthropometry.chest
          fill_in 'anthropometry_comment', with: anthropometry.comment
          find('.btn-sent').click
        end
        # it { expect { (find('.btn-sent').click) }.to change(Anthropometry, :count).by(1) }
        it { expect(page).to have_content(anthropometry.cranium) }
        it { expect(page).to have_content(anthropometry.comment) }
        it { expect(page).to have_content(t('activerecord.successful.messages.anthropometry.created')) }
        it { expect(page).to have_content(t('page.anthropometry.list')) }
        it { expect(page).to have_css('.remove-anthropometry') }
        describe 'click delete record' do
          before do
            find('.remove-anthropometry').click
          end
          # it { expect(page).to have_content t('are_you_sure') }
          it { expect(page).to have_content t('activerecord.successful.messages.anthropometry.deleted') }
        end
      end
    end
  end
  # describe 'in the Character pages with characters' do
  #   let!(:character) { FactoryGirl.create(:character, user: @user) }
  #   before do
  #     login_as @user, scope: :user
  #     visit users_path
  #   end
  #   it 'should view non-empty list characters' do
  #     expect(page).to have_css('.home-characters-list')
  #     expect(page).to have_link(t('patients.create'), href: new_character_path)
  #     expect(page).to have_link('', href: edit_character_path(character))
  #   end
  #   describe 'edit character' do
  #     before { click_link('', href: edit_character_path(character)) }
  #     it { expect(page).to have_content character.name }
  #     it { expect(page).to have_title t('page.character.edit') }
  #   end
  # end
  # describe 'Edit character' do
  #   let!(:character) { FactoryGirl.create(:character, user: @user) }
  #   before do
  #     login(@user)
  #     page.click_link('', :href => edit_character_path(character))
  #   end
  #   describe 'should have content' do
  #     it { expect(page).to have_content character.name }
  #     it { expect(page).to have_title t('page.character.edit') }
  #   end
  #   it :js => true do
  #     expect { click_link t('edit.delete') }.to change(Character, :count).by(-1)
  #     expect(page).to have_css('.alert-success')
  #   end
  #   it { expect(page).to have_content character.name }
  # end
end
