require 'rails_helper'

RSpec.describe CommentDecorator do
  let(:decorator) { described_class.new(comment) }
  let(:book)      { build :ebook }
  let(:comment)   { create :comment, book: book }

  describe '#formatted_created_at' do
    subject { decorator.formatted_created_at }

    it { is_expected.to eql('less than a minute ago') }
  end
end
