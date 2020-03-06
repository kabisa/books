require 'rails_helper'

describe Material::NavigationIcon, type: :component do
  subject       { Capybara.string html }
  let(:html)    {  render_inline(described_class.new(options)) }
  let(:options) { { action_name: action_name } }

  context 'with index action' do
    let(:action_name) { 'index' }

    it { is_expected.to have_css('button.navbar-toggler[data-toggle="navdrawer"] span.navbar-toggler-icon') }
  end

  %w(create update).each do |action_name|
    context "with #{action_name} action" do
      let(:action_name) { action_name }

      it { is_expected.to have_css('a.navbar-toggler[href="/"][data-toggle="tooltip"][data-placement="right"] i.material-icons', text: 'arrow_back') }
    end
  end

  context 'with other action' do
    let(:action_name) { 'show' }

    it { is_expected.to have_css('a.navbar-toggler[href="javascript:history.back()"][data-toggle="tooltip"][data-placement="right"] i.material-icons', text: 'arrow_back') }
  end
end
