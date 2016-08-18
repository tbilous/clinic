require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar") }

  subject { @user }
  
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:characters) }
  

  describe "character associations" do
    before { @user.save }
    let!(:character) do
      FactoryGirl.create(:character, user: @user)
    end
    let!(:older_character) do
      # FactoryGirl.create(:character, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_character) do
      # FactoryGirl.create(:character, user: @user, created_at: 1.hour.ago)
    end
    
    it "should destroy associated characters" do
      characters = @user.characters.to_a
      @user.destroy
      expect(characters).not_to be_empty
      characters.each do |character|
        expect(Character.where(id: character.id)).to be_empty
      end
    end
  end
end