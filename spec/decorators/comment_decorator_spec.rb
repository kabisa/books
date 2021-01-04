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
        #{'Bla ' * 10}
        #{'Bla ' * 20}
        Bla
      BODY
    end
    let(:comment) { create :comment, body: body, book: book }

    it { expect(subject.size).to eql(120) }
    it { is_expected.to end_with('...') }
  end

  describe '#truncated_body_html' do
    subject { Capybara.string decorator.truncated_body_html }
    let(:body) do
      <<~BODY
        Bla
        #{'Bla ' * 10}
        #{'Bla ' * 20}
        Bla
      BODY
    end
    let(:comment) { create :comment, body: body, book: book }

    it { expect(subject.text.size).to eql(120) }
    it { is_expected.to have_css('p') }
    it { is_expected.to have_css('br', count: 2) }
    it { is_expected.to have_content('...') }
  end

  describe '#commenter_html' do
    before        { allow(h).to receive(:current_user).and_return(user) }

    subject       { Capybara.string(decorator.commenter_html) }

    let(:user)    { create(:user, email: 'john.doe@kabisa.nl') }
    let(:comment) { create :comment, book: book, user: commenter }

    context 'known comment' do
      context 'user views his own comment' do
        let(:commenter) { user }

        it { is_expected.to have_css('small span.badge.badge-pill.badge-light', text: commenter.email) }
        it { is_expected.to have_css('small span.text-black-secondary', text: 'less than a minute ago') }
      end

      context 'user views other comment' do
        let(:commenter) { create(:user) }
        it { is_expected.to have_css('strong', text: commenter.email) }
        it { is_expected.to have_css('small span.text-black-secondary', text: 'less than a minute ago') }
      end
    end

    context 'anonymous comment' do
      before { commenter.update(comments_anonymously: true) }

      context 'user views his own comment' do
        let(:commenter) { user }

        it { is_expected.to have_css('small span.badge.badge-pill.badge-light', text: commenter.email) }
        it { is_expected.to have_css('small span.text-black-secondary', text: 'less than a minute ago') }
      end

      context 'user views other comment' do
        let(:commenter) { create(:user) }

        it { is_expected.to have_css('strong', text: 'anonymous') }
        it { is_expected.to have_css('small span.text-black-secondary', text: 'less than a minute ago') }
      end
    end
  end
end
