require 'rails_helper'

describe "Static pages" do
  subject { page }
  let(:heading)    { 'Clinic' }
  
  describe "Home page" do
    before { visit root_path }
    let(:page_title) { 'Home' }
    
    it { should have_selector('h1', text: page_title) }
    it { should have_title(heading) }
  end
  describe "About page" do
    before { visit about_path }
    let(:page_title) { 'About Us' }
    
    it { should have_selector('h1', text: page_title) }
    it { should have_title(heading) }
  end
    # Test routes links
  describe "Right links" do
    it "should have the right links on the layout" do
      visit root_path
      page.find("#logo")
      expect(page).to have_title(heading)
      expect(page).to have_selector('h1', text: 'Home')
      
      click_link "About Us"
      expect(page).to have_title(heading)
      expect(page).to have_selector('h1', text: 'About Us')
      
      click_link "Home"
      expect(page).to have_title(heading)
      expect(page).to  have_selector('h1', text: 'Home')
      
      # click_link "Sign up now!"
      # expect(page).to have_title('Sign up')
  end
  end
end