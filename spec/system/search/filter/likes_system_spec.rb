require 'rails_helper'

# This tests uses the preview located in spec/components/previews...
# and test the JS behaviour managed by Stimulus.
RSpec.describe Search::Filter::Likes, type: :system do
  let(:preview_path) { '/rails/components/search/filter/likes/' }

  describe 'with_no_likes' do
    before { visit preview_path.concat('with_no_likes') }

    it 'has a title' do
      expect(page).to have_css('.dropdown a:not(.btn-outline-primary)[href="#"]', text: 'LIKES')
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

      expect(page).to have_css('.dropdown a.btn-outline-primary[href="#"]', text: 'AT LEAST 5')
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
      expect(page).to have_css('.dropdown a.btn-outline-primary[href="#"]', text: 'AT LEAST 5')
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

      expect(page).to have_css('.dropdown a:not(.btn-outline-primary)[href="#"]', text: 'LIKES')
      expect(page).to have_css('.dropdown-menu', text: 'Any')

      expect(page).not_to have_css('.dropdown-menu', text: 'At least 5')
      expect(page).not_to have_css('.dropdown-menu', text: 'Clear')
    end

    it 'resets content' do
      open_dropdown
      click_on 'Clear'

      expect(page).to have_css('.dropdown a:not(.btn-outline-primary)[href="#"]', text: 'LIKES')
      expect(page).to have_css('.dropdown-menu', text: 'Any')

      expect(page).not_to have_css('.dropdown-menu', text: 'At least 5')
      expect(page).not_to have_css('.dropdown-menu', text: 'Clear')
    end

    def open_dropdown
      click_on('At least 5')
    end
  end

  def change_range_input(locator, value)
    find_field(locator).execute_script "this.value = #{value}; this.dispatchEvent(new Event('input'));"
  end
end
