require 'rails_helper'

RSpec.describe UserDecorator do
  let(:decorator) { described_class.new(user) }

  describe '#to_label' do
    subject { decorator.to_label }

    let(:user) { create(:user, name: name) }
    let(:name) { nil }

    describe 'without name' do
      let(:email) { user.email }

      it { is_expected.to eql(email) }
    end

    describe 'with name' do
      let(:name) { 'John Doe' }

      it { is_expected.to eql(name) }
    end

    describe 'with long name' do
      let(:name) { 'Aladin Sarsippius Sulemanagic Jackson the third' }
      let(:truncated_name) { 'Aladin Sarsippius Sule...' }

      it { is_expected.to eql(truncated_name) }
    end
  end
end
