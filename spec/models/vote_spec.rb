require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { is_expected.to act_as_paranoid }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:book) }
  end

  describe '.policy_class' do
    subject { described_class.policy_class }

    it { is_expected.to eql(VotePolicy) }
  end
end
