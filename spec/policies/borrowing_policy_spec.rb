require 'rails_helper'

describe BorrowingPolicy, type: :policy do
  subject { described_class.new(user, borrowing) }
  let(:book) { build :book }
  let(:user) { build :user }
  let(:borrowing) { build :borrowing, user: borrower, copy: book.copies.first }

  context 'authorized user' do
    let(:borrower) { user }

    it { is_expected.to permit_action(:destroy) }
  end

  context 'unauthorized user' do
    let(:borrower) { build :user }

    it { is_expected.to forbid_action(:destroy) }
  end
end
