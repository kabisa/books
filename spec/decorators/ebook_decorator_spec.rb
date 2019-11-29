require 'rails_helper'

RSpec.describe EbookDecorator do
  let(:decorator) { described_class.new(instance) }
  let(:instance)  { build :ebook }

  describe '#download_link' do
    subject         { decorator.download_link }

    it 'is a link' do
      expect(subject).to have_css("a[target='_blank'][href='#{instance.link}']", text: 'Download')
    end

    it 'acts as a button' do
      expect(subject).to have_css('a.btn[role="button"]')
    end
  end

  describe '#formatted_type' do
    subject { decorator.formatted_type }

    it { is_expected.to eql('E-book') }
  end

  describe '#book_type_icon' do
    subject    { Capybara.string decorator.book_type_icon }

    it { is_expected.to have_css('i.material-icons[title="E-book"][data-toggle="tooltip"]', text: 'tablet_android') }
  end
end
