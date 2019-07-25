require 'rails_helper'

describe BookPolicy, type: :policy do
  subject { described_class.new(user, book) }
  let(:book) { build :book }

  context 'authorized user' do
    let(:user) { build :user }

    it { is_expected.to permit_action(:new) }
  end

  context 'unauthorized user' do
    let(:user) { build :guest }

    it { is_expected.to forbid_action(:new) }
  end

end
