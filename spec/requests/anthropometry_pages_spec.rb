require 'rails_helper'

RSpec.describe "AnthropometryPage", type: :view do
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
    # it 'should not view empty list characters' do
    #   expect(page).to_not have_css('.home-characters-list')
    #   expect(page).to have_link(t('patients.create'), href: new_character_path)
    # end
    describe 'should have character' do
      before do
        visit root_path
        # click_link('Some Button')
        find('.activate-patient').click
      end
      # it {puts page.body }
      it { expect(page).to have_content character.name }
      # it { puts page.body }
      # it { (find('.activate-patient').click)  }
      # describe 'wrong validations' do
      #   before { (find('.btn-sent').click) }
      #   it { expect(page).to have_css('.alert.alert-danger') }
      #   it { expect(response).to render_template('new') }
      # end
      describe 'visit Active Patient page' do
        before { click_link(t('patient.active')) }
        it { expect(page).to have_content character.name }
        describe 'create anthropometry' do
          before do
            adata_params = FactoryGirl.attributes_for(:adata, user_id: @user, character_id: character.id)
            fill_in 'anthropometry_comment', with: character.comment
            find('#anthropometry_date_1i').select(DateTime.now.year.to_s)
            find('#anthropometry_date_2i').select(Date::MONTHNAMES[DateTime.now.month])
            find('#anthropometry_date_3i').select(DateTime.now.day.to_s)
            fill_in 'anthropometry_name', with: adata_params.height
            fill_in 'character_comment', with: adata_params.weight
            fill_in 'character_comment', with: adata_params.cranium
            fill_in 'character_comment', with: adata_params.chest
          end
        end
        it { expect { (find('.btn-sent').click) }.to change(Anthropometry, :count).by(1) }
        describe 'check result' do
          # before { (find('.btn-sent').click) }
          # it { expect(page).to have_css('.home-characters-list') }
          # it { expect(page).to have_content character.name }
          # it { expect(page).to have_content character.comment }
          # it { expect(page).to have_css '.glyphicon-pencil' }
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
