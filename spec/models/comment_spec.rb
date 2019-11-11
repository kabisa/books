require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { is_expected.to act_as_paranoid }

  describe 'default_scope' do
    it 'applies a default scope to collections' do
      # TODO: test `includes(:user)`
      expect(described_class.all.to_sql).to eq described_class.order(created_at: :desc).to_sql
    end
  end

  describe 'validations' do
    it { is_expected.to validate_length_of(:body).is_at_most(1024) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:book) }
  end
end
