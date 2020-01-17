require 'rails_helper'
require 'book_search'

RSpec.describe BookSearch do
  describe '#search' do
    subject { instance.search }

    let(:instance) { described_class.new(ActionController::Parameters.new(params)) }

    let(:params) do
      {
        q: {
          likes_count_gteq: "0",
          num_of_pages_gteq:  "0",
          num_of_pages_lteq: "500"
        }
      }
    end

    it { expect(subject.likes_count_gteq).to eql(0) }
    it { expect(subject.num_of_pages_gteq).to eql(0) }
    it { expect(subject.num_of_pages_lteq).to eql(500) }

    it { is_expected.to be_a(Ransack::Search) }
    it do
      expect(subject.sorts.map(&:name)).to contain_exactly('title')
    end

    describe 'with block given' do
      subject { instance.search { |q| return q }}

      it { expect(subject.likes_count_gteq).to be_nil }
      it { expect(subject.num_of_pages_gteq).to be_nil }
      it { expect(subject.num_of_pages_lteq).to be_nil }
    end

    context 'without params' do
      let(:params) do
        {}
      end

      it { expect(subject.likes_count_gteq).to eql(0) }
      it { expect(subject.num_of_pages_gteq).to eql(0) }
      it { expect(subject.num_of_pages_lteq).to eql(500) }

      describe 'block given' do
        subject { instance.search { |q| return q }}

        it { expect(subject.likes_count_gteq).to be_nil }
        it { expect(subject.num_of_pages_gteq).to be_nil }
        it { expect(subject.num_of_pages_lteq).to be_nil }
      end
    end

    context 'with params set' do
      let(:params) do
        {
          q: {
            likes_count_gteq: "10",
            num_of_pages_gteq:  "25",
            num_of_pages_lteq: "200"
          }
        }
      end

      it { expect(subject.likes_count_gteq).to eql(10) }
      it { expect(subject.num_of_pages_gteq).to eql(25) }
      it { expect(subject.num_of_pages_lteq).to eql(200) }

      describe 'block given' do
        subject { instance.search { |q| return q }}

        it { expect(subject.likes_count_gteq).to eql(10) }
        it { expect(subject.num_of_pages_gteq).to eql(25) }
        it { expect(subject.num_of_pages_lteq).to eql(200) }
      end
    end
  end
end

