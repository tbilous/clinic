require 'rails_helper'

describe "Static pages" do

  # describe "Home page" do

  #   it "should have the content 'Home'" do
  #     visit '/static_pages/home'
  #     expect(page).to have_content('Home') | have_content('Домівка')
  #   end
  # end
  # describe "About page" do

  #   it "should have the content 'About Us'" do
  #     visit '/static_pages/about'
  #     expect(page).to have_content('About Us') | have_content('Про нас')
  #   end
  # end
  describe "Home page" do

    it "Do not changed the locale of content 'Home'" do
      visit '/static_pages/home'
      expect(page).to have_content('Home')
    end
    
    it "Do not changed the locale of title" do
      visit '/static_pages/home'
      expect(page).to have_title("Clinic")
    end
  end
end