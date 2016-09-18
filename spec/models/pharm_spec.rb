require 'rails_helper'

RSpec.describe Pharm, type: :model do
  let(:user) { FactoryGirl.create(:user) }

  before { @pharm = user.pharms.build(user_id: user.id, name: 'Example Item', comment: 'Item instruction', attention: 'Pharm attention',  dose: 1.1, volume: 1.1, pharmowner_id: 1, type_id: 1 ) }

  subject { @pharm }

  it { should respond_to(:user_id) }
  it { should respond_to(:name) }
  it { should respond_to(:comment) }
  it { should respond_to(:attention) }
  it { should respond_to(:dose) }
  it { should respond_to(:volume) }
  it { should respond_to(:type_id) }
  it { should respond_to(:pharmowner_id) }

  it { should be_valid }

  describe 'when user_id is not present' do
    before { @pharm.user_id = nil }
    it { should_not be_valid }
  end
  describe 'with blank name' do
    before { @pharm.name = ' ' }
    it { should_not be_valid }
  end
  describe 'with name that is too short' do
    before { @pharm.name = 'a' }
    it { should_not be_valid }
  end
  describe 'with name that is too long' do
    before { @pharm.name = 'a' * 125 }
    it { should_not be_valid }
  end
  describe 'with comment that is too long' do
    before { @pharm.comment = 'a' * 501 }
    it { should_not be_valid }
  end
  describe 'with comment that is too long' do
    before { @pharm.attention = 'a' * 125 }
    it { should_not be_valid }
  end
  describe 'with comment that is too short' do
    before { @pharm.comment = 'a' }
    it { should_not be_valid }
  end
  describe 'with blank volume' do
    before { @pharm.volume  = nil  }
    it { should_not be_valid }
  end
  describe 'with blank dose' do
    before { @pharm.dose  = nil  }
    it { should_not be_valid }
  end
  describe 'with blank type' do
    before { @pharm.type_id  = nil  }
    it { should_not be_valid }
  end
  describe 'with blank type' do
    before { @pharm.pharmowner_id  = nil  }
    it { should_not be_valid }
  end

  it 'should destroy associated contacts' do
    pharms = user.pharms.to_a
    user.destroy
    expect(pharms).not_to be_empty
    pharms.each do |pharm|
      expect(Pharm.where(id: pharm.id)).to be_empty
    end
  end
end