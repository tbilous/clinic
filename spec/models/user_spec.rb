require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new }
    it { should respond_to(:name) }
    it { should respond_to(:email) }
    it { should respond_to(:password) }
end