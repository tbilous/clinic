require 'rails_helper'

RSpec.describe PharmOwner, type: :model do
  let(:user) { FactoryGirl.create(:user) }

  before do
    @ph_owner = user.pharm_owners.build(user_id: user.id,
                                        name: 'Example Pharm Owner',
                                        comment: 'Pharm Owner Comment')
  end

  subject { @ph_owner }

  it { should respond_to(:user_id) }
  it { should respond_to(:name) }
  it { should respond_to(:comment) }

  it { should be_valid }

  describe 'when user_id is not present' do
    before { @ph_owner.user_id = nil }
    it { should_not be_valid }
  end
  describe 'with blank name' do
    before { @ph_owner.name = ' ' }
    it { should_not be_valid }
  end
  describe 'with name that is too long' do
    before { @ph_owner.name = 'a' * 81 }
    it { should_not be_valid }
  end
  describe 'with comment that is too long' do
    before { @ph_owner.comment = 'a' * 501 }
    it { should_not be_valid }
  end

  it 'should destroy associated contacts' do
    ph_owner = user.pharm_owners.to_a
    user.destroy
    expect(ph_owner).not_to be_empty
    ph_owner.each do |owner|
      expect(PharmOwner.where(id: owner.id)).to be_empty
    end
  end
end
