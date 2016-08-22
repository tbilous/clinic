require 'rails_helper'

RSpec.describe Character, type: :model do
  
  # subject { described_class.new }
  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }
  
  before { @character = user.characters.build(name: "Example Character", comment: 'My son', birthday: Time.new(1973, 10, 15),  sex: true, user_id: user.id) }

  subject { @character }
  
  it { should respond_to(:name) }
  it { should respond_to(:comment) }
  it { should respond_to(:birthday) }
  it { should respond_to(:sex) }
  # it { should respond_to(:active) }
  it { should respond_to(:usd) }
  it { should respond_to(:user_id) }
  
  it { should be_valid }
  
  describe "when user_id is not present" do
    before { @character.user_id = nil }
    it { should_not be_valid }
  end
  describe "with blank name" do
    before { @character.name = " " }
    it { should_not be_valid }
  end
  describe "with content that is too long" do
    before { @character.name = "a" * 121 }
    it { should_not be_valid }
  end
  
  it "should destroy associated characters" do
    characters = user.characters.to_a
    user.destroy
    expect(characters).not_to be_empty
    characters.each do |character|
      expect(Character.where(id: character.id)).to be_empty
    end
  end

end
