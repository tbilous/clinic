require 'rails_helper'

RSpec.describe PharmType, type: :model do
  let(:user) { FactoryGirl.create(:user) }

  before { @item_type = user.pharm_types.build(user_id: user.id, name: 'Example Item Type name', slug: 'slug', comment: 'Type comment'  ) }

  subject { @item_type }

  it { should respond_to(:user_id) }
  it { should respond_to(:name) }
  it { should respond_to(:slug) }
  it { should respond_to(:comment) }

  it { should be_valid }

  describe 'when user_id is not present' do
    before { @item_type.user_id = nil }
    it { should_not be_valid }
  end
  describe 'with blank name' do
    before { @item_type.name = ' ' }
    it { should_not be_valid }
  end
  describe 'with name that is too long' do
    before { @item_type.name = 'a' * 125 }
    it { should_not be_valid }
  end
  describe 'with blank slug' do
    before { @item_type.slug  = nil  }
    it { should_not be_valid }
  end
  describe 'with slug that is too long' do
    before { @item_type.slug = 'a' * 13 }
    it { should_not be_valid }
  end

  it 'should destroy associated contacts' do
    types = user.pharm_types.to_a
    user.destroy
    expect(types).not_to be_empty
    types.each do |type|
      expect(PharmType.where(id: type.id)).to be_empty
    end
  end
end