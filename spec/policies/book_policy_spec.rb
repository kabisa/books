require 'rails_helper'

describe BookPolicy, type: :policy do
  subject { policy }

  let(:policy) { described_class.new(user, book) }
  let(:book) { build :book }

  context 'authorized user' do
    let(:user) { build :user }

    it { is_expected.to permit_action(:new) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:borrow) }
    it { is_expected.to permit_action(:destroy) }
    it { is_expected.to permit_action(:show) }

    context '#permitted_attributes' do
      subject { policy.permitted_attributes }

      it { is_expected.to include(:title) }
      it { is_expected.to include(:link) }
      it { is_expected.to include(:cover, :cover_cache, :remove_cover) }
      it { is_expected.to include(:summary) }
      it { is_expected.to include(:writer_names) }
      it { is_expected.to include(:tag_list) }
      it { is_expected.to include(:num_of_pages) }
      it { is_expected.to include(copies_attributes: [:id, :location_id, :number, :_destroy]) }
    end
  end

  context 'unauthorized user' do
    let(:user) { build :guest }

    it { is_expected.to forbid_action(:new) }
    it { is_expected.to forbid_action(:create) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:borrow) }
    it { is_expected.to forbid_action(:destroy) }
    it { is_expected.to permit_action(:show) }

    context '#permitted_attributes' do
      subject { policy.permitted_attributes }

      it { is_expected.to be_nil }
    end
  end

end
