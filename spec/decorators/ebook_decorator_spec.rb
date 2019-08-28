require 'rails_helper'

RSpec.describe EbookDecorator do
  describe '#download_link' do
    subject         { decorator.download_link }
    let(:instance)  { build :ebook }
    let(:decorator) { described_class.new(instance) }

    it 'is a link' do
      expect(subject).to have_css("a[target='_blank'][href='#{instance.link}']")
    end

    it 'shows an icon' do
      expect(subject).to have_css("a i.material-icons", text: 'cloud_download')
    end

    it 'has a tooltip' do
      expect(subject).to have_css("a i[title='Download'][data-toggle='tooltip']")
    end
  end
end
