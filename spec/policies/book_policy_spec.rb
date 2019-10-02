require 'rails_helper'

describe BookPolicy, type: :policy do
  subject { described_class.new(user, book) }
  let(:book) { build :book }

  context 'authorized user' do
    let(:user) { build :user }

    it { is_expected.to permit_action(:new) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:borrow) }
    it { is_expected.to permit_action(:destroy) }
    it { is_expected.to permit_action(:show) }
  end

  context 'unauthorized user' do
    let(:user) { build :guest }

    it { is_expected.to forbid_action(:new) }
    it { is_expected.to forbid_action(:create) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:borrow) }
    it { is_expected.to forbid_action(:destroy) }
    it { is_expected.to permit_action(:show) }
  end

end
