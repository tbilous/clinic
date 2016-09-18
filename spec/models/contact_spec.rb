require 'rails_helper'

RSpec.describe Contact, type: :model do
  
  # subject { described_class.new }
  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }
  
  before { @contact = user.contacts.build(name: 'Example Contact', comment: 'My contact', phone: '1231231212', address: 'Nezalezgnosti ave', email: 'contact@contact.com', latitude: '', longitude: '', photo: '', user_id: user.id) }

  subject { @contact }
  
  it { should respond_to(:name) }
  it { should respond_to(:comment) }
  it { should respond_to(:address) }
  it { should respond_to(:phone) }
  it { should respond_to(:email) }
  it { should respond_to(:latitude) }
  it { should respond_to(:longitude) }
  it { should respond_to(:photo) }
  it { should respond_to(:user_id) }
  
  it { should be_valid }
  
  describe 'when user_id is not present' do
    before { @contact.user_id = nil }
    it { should_not be_valid }
  end
  describe 'with blank name' do
    before { @contact.name = ' ' }
    it { should_not be_valid }
  end
  describe 'with name that is too long' do
    before { @contact.name = 'a' * 61 }
    it { should_not be_valid }
  end
  describe 'with comment that is too long' do
    before { @contact.comment = 'a' * 256 }
    it { should_not be_valid }
  end
  describe 'with address that is too long' do
    before { @contact.address = 'a' * 256 }
    it { should_not be_valid }
  end
  describe 'with phone that is too long' do
    before { @contact.phone = 'a' * 26 }
    it { should_not be_valid }
  end
  describe 'with email that is too long' do
    before { @contact.email = 'a' * 61 }
    it { should_not be_valid }
  end
  
  it 'should destroy associated contacts' do
    contacts = user.contacts.to_a
    user.destroy
    expect(contacts).not_to be_empty
    contacts.each do |contact|
      expect(Contact.where(id: contact.id)).to be_empty
    end
  end
end
