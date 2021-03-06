require 'rails_helper'

# This tests uses the preview located in spec/components/previews...
# and test the JS behaviour managed by Stimulus.
RSpec.describe Search::Filter::LikesComponent, type: :system do
  before { driven_by(:selenium_headless) }

  let(:preview_path) { '/rails/view_components/search/filter/likes_component/' }

  describe 'with_no_likes' do
    before { visit preview_path.concat('with_no_likes') }

    it 'has a title' do
      expect(page).to have_css(
        '.dropdown a.dropdown-toggle[href="#"]',
        text: 'LIKES'
      )
    end

    it 'has no colored border' do
      expect(page).to have_css(
        '.dropdown .btn-group.btn-group-fluid.border:not(.border-primary)'
      )
    end

    it 'has content' do
      open_dropdown
      expect(page).to have_css('.dropdown-menu', text: 'Any')

      expect(page).not_to have_css('.dropdown-menu', text: 'At least 5')
      expect(page).not_to have_css('.dropdown-menu', text: 'Clear')
    end

    it 'updates content' do
      open_dropdown
      change_range_input('q_likes_count_gteq', 5)

      expect(page).to have_css(
        '.dropdown .btn-group.btn-group-fluid.border.border-primary'
      )
      expect(page).to have_css(
        '.dropdown a.text-primary[href="#"]',
        text: 'AT LEAST 5'
      )
      expect(page).to have_css('.dropdown-menu', text: 'At least 5')
      expect(page).to have_css('.dropdown-menu', text: 'Clear')

      expect(page).not_to have_css('.dropdown-menu', text: 'Any')
    end

    def open_dropdown
      click_on('Likes')
    end
  end

  describe 'with_any_likes' do
    before { visit preview_path.concat('with_any_likes') }

    it 'has a title' do
      expect(page).to have_css(
        '.dropdown a.text-primary[href="#"]',
        text: 'AT LEAST 5'
      )
    end

    it 'has a colored border' do
      expect(page).to have_css(
        '.dropdown .btn-group.btn-group-fluid.border.border-primary'
      )
    end

    it 'has content' do
      open_dropdown
      expect(page).to have_css('.dropdown-menu', text: 'At least 5')
      expect(page).to have_css('.dropdown-menu', text: 'Clear')

      expect(page).not_to have_css('.dropdown-menu', text: 'Any')
    end

    it 'updates content' do
      open_dropdown
      change_range_input('q_likes_count_gteq', 0)

      expect(page).to have_css(
        '.dropdown a.dropdown-toggle[href="#"]',
        text: 'LIKES'
      )
      expect(page).to have_css('.dropdown-menu', text: 'Any')

      expect(page).not_to have_css('.dropdown-menu', text: 'At least 5')
      expect(page).not_to have_css('.dropdown-menu', text: 'Clear')
    end

    it 'resets content' do
      open_dropdown
      click_on 'Clear'

      expect(page).to have_css(
        '.dropdown .btn-group.btn-group-fluid.border:not(.border-primary)'
      )
      expect(page).to have_css(
        '.dropdown a.dropdown-toggle[href="#"]',
        text: 'LIKES'
      )
      expect(page).to have_css('.dropdown-menu', text: 'Any')

      expect(page).not_to have_css('.dropdown-menu', text: 'At least 5')
      expect(page).not_to have_css('.dropdown-menu', text: 'Clear')
    end

    it 'also resets content' do
      find('[data-controller="likes"] .dropdown-toggle-split').click
      click_on('Likes')

      expect(page).to have_css(
        '.dropdown .btn-group.btn-group-fluid.border:not(.border-primary)'
      )
      expect(page).to have_css(
        '.dropdown a.dropdown-toggle[href="#"]',
        text: 'LIKES'
      )
      expect(page).to have_css('.dropdown-menu', text: 'Any')

      expect(page).not_to have_css('.dropdown-menu', text: 'At least 5')
      expect(page).not_to have_css('.dropdown-menu', text: 'Clear')
    end

    def open_dropdown
      click_on('At least 5')
    end
  end

  def change_range_input(locator, value)
    find_field(locator).execute_script "this.value = #{
                                         value
                                       }; this.dispatchEvent(new Event('input'));"
  end
end
