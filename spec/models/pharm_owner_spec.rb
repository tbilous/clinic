require 'rails_helper'

RSpec.describe PharmGroup, type: :model do
  let(:user) { FactoryGirl.create(:user) }

  before { @item = user.items.build(user_id: user.id, name: 'Example Item', info: 'Item instruction', type_id: '',   dose: '', volume: '' ) }

  subject { @item }

  it { should respond_to(:user_id) }
  it { should respond_to(:name) }
  it { should respond_to(:info) }
  it { should respond_to(:type_id) }
  it { should respond_to(:dose) }
  it { should respond_to(:volume) }

  it { should be_valid }

  describe 'when user_id is not present' do
    before { @item.user_id = nil }
    it { should_not be_valid }
  end
  describe 'with blank name' do
    before { @item.name = ' ' }
    it { should_not be_valid }
  end
  describe 'with name that is too long' do
    before { @item.name = 'a' * 125 }
    it { should_not be_valid }
  end
  describe 'with comment that is too long' do
    before { @item.info = 'a' * 500 }
    it { should_not be_valid }
  end
  describe 'with blank value' do
    before { @item.value  = ' '  }
    it { should_not be_valid }
  end
  describe 'with blank dose' do
    before { @item.dose  = ' '  }
    it { should_not be_valid }
  end
  describe 'with blank tyoe' do
    before { @item.type  = ' '  }
    it { should_not be_valid }
  end

  it 'should destroy associated contacts' do
    items = user.items.to_a
    user.destroy
    expect(items).not_to be_empty
    items.each do |item|
      expect(Item.where(id: item.id)).to be_empty
    end
  end
end