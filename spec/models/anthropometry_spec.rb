require 'rails_helper'

RSpec.describe Anthropometry, type: :model do

  # subject { described_class.new }
  let(:user) { FactoryGirl.create(:user) }
  let(:character) { FactoryGirl.create(:character, user: user) }

  before { @adata = user.anthropometries.build(comment: 'Example A-data', date: Time.now, user_id: user.id, character_id: character, height: 92, weight: 12.5) }

  subject { @adata }

  it { should respond_to(:date) }
  it { should respond_to(:comment) }
  it { should respond_to(:height) }
  it { should respond_to(:weight) }
  it { should respond_to(:cranium) }
  it { should respond_to(:chest) }
  it { should respond_to(:user_id) }
  it { should respond_to(:character_id) }


  describe "when user_id is not present" do
    before do
      @adata.user_id = nil
      @adata.character_id = nil
    end
    it { should_not be_valid }
  end
  describe "with blank date" do
    before { @adata.date = " " }
    it { should_not be_valid }
  end
  describe "with comment that is too long" do
    before { @adata.comment = "a" * 121 }
    it { should_not be_valid }
  end

  describe 'should destroy associated characters' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:character) { FactoryGirl.create(:character, user: user) }
    before do
      antropometries_params = FactoryGirl.attributes_for(:adata, user: user, character: character)
      adata = character.anthropometries.build(antropometries_params)
      adata.save
    end
    it do
      anthropometries = character.anthropometries.to_a
      character.destroy
      expect(anthropometries).not_to be_empty
      anthropometries.each do |anthropometry|
        expect(Anthropometry.where(id: anthropometry.id)).to be_empty
      end
    end
  end
end
