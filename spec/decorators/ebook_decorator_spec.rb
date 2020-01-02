require 'rails_helper'

RSpec.describe EbookDecorator do
  let(:decorator) { described_class.new(instance) }
  let(:instance)  { build :ebook }

  describe '#link_to_borrow' do
    let(:html) { decorator.link_to_borrow }

    before { allow(h).to receive(:policy).and_return(policy_stub) }

    describe 'authorized user' do
      subject           { Capybara.string html }
      let(:policy_stub) { double('BookPolicy', borrow?: true) }

      it { is_expected.to have_css("a[target='_blank'][href='#{instance.link}']", text: 'Download') }
    end

    describe 'unauthorized user' do
      subject           { html }
      let(:policy_stub) { double('BookPolicy', borrow?: false) }

      it { is_expected.to be_nil }
    end
  end

  describe '#formatted_type' do
    subject { decorator.formatted_type }

    it { is_expected.to eql('E-book') }
  end

  describe '#book_type_icon' do
    subject { Capybara.string decorator.book_type_icon }

    it { is_expected.to have_css('i.material-icons[title="E-book"][data-toggle="tooltip"]', text: 'tablet_android') }
  end
end
