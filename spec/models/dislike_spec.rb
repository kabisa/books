require 'rails_helper'

RSpec.describe Dislike, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:book).counter_cache(true) }
  end
end
