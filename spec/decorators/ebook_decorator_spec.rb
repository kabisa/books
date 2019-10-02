require 'rails_helper'

RSpec.describe EbookDecorator do
  describe '#download_link' do
    subject         { decorator.download_link }
    let(:instance)  { build :ebook }
    let(:decorator) { described_class.new(instance) }

    it 'is a link' do
      expect(subject).to have_css("a[target='_blank'][href='#{instance.link}']", text: 'Download')
    end

    it 'acts as a button' do
      expect(subject).to have_css('a.btn[role="button"]')
    end
  end
end
