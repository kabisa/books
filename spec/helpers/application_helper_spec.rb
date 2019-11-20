require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#show_more_link_to' do
    subject { helper.show_more_link_to(scope, name, options) }
    before do
      allow(helper).to receive(:material_icon).and_return('icon')
    end
    let(:scope) { double('scope') }
    let(:name) { 'Ipsum' }
    let(:options) { {} }

    it do
      expect(helper).to receive(:link_to_next_page).with(scope, "icon #{name}", hash_including(:data))
      subject
    end
  end
end
