require 'rails_helper'

describe 'Static pages' do
  subject { page }
  let(:heading)    { t(:site_name) }
  
  describe 'About page' do
    before { visit about_path }
    let(:page_title) { t(:page_about) }
    
    it { should have_selector('h1', text: page_title) }
    it { should have_title(heading) }
  end
    # Test routes links
  describe 'Right links' do
    it 'should have the right links on the layout' do
      visit root_path
      page.find("#logo")
      expect(page).to have_title(heading)
      
      click_link t(:page_about)
      expect(page).to have_title(heading)
      expect(page).to have_selector('h1', text: 'About Us')
    end
  end
end