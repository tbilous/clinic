require 'rails_helper'

RSpec.describe PharmGroup, type: :model do
  let(:user) { FactoryGirl.create(:user) }

  before { @pharm_group = user.pharm_groups.build(user_id: user.id, name: 'Example Item', comment: 'Item instruction') }

  subject { @pharm_group }

  it { should respond_to(:user_id) }
  it { should respond_to(:name) }
  it { should respond_to(:comment) }

  it { should be_valid }

  describe 'when user_id is not present' do
    before { subject.user_id = nil }
    it { should_not be_valid }
  end
  describe 'with blank name' do
    before { subject.name = ' ' }
    it { should_not be_valid }
  end
  describe 'with name that is too long' do
    before { subject.name = 'a' * 126 }
    it { should_not be_valid }
  end
  describe 'with comment that is too long' do
    before { subject.comment = 'a' * 501 }
    it { should_not be_valid }
  end

  it 'should destroy associated contacts' do
    groups = user.pharm_groups.to_a
    user.destroy
    expect(groups).not_to be_empty
    groups.each do |group|
      expect(PharmGroup.where(id: group.id)).to be_empty
    end
  end
end
