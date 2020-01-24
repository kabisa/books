require 'rails_helper'

RSpec.describe CommentDecorator do
  let(:decorator) { described_class.new(comment) }
  let(:book)      { build :book }
  let(:comment)   { create :comment, book: book }

  describe '#formatted_created_at' do
    subject { decorator.formatted_created_at }

    it { is_expected.to eql('less than a minute ago') }
  end

  describe '#truncated_body' do
    subject {  decorator.truncated_body }
    let(:body) do
      <<~BODY
        Bla
        #{"Bla " * 10}
        #{"Bla " * 20}
        Bla
      BODY
    end
    let(:comment) { create :comment, body: body, book: book }

    it { expect(subject.size).to eql(120) }
    it { is_expected.to have_content('...') }
  end

  describe '#truncated_body_html' do
    subject { Capybara.string decorator.truncated_body_html }
    let(:body) do
      <<~BODY
        Bla
        #{"Bla " * 10}
        #{"Bla " * 20}
        Bla
      BODY
    end
    let(:comment) { create :comment, body: body, book: book }

    it { expect(subject.text.size).to eql(120) }
    it { is_expected.to have_css('p') }
    it { is_expected.to have_css('br', count: 2) }
    it { is_expected.to have_content('...') }
  end
end
