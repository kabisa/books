require 'rails_helper'

# This tests uses the preview located in spec/components/previews...
# and test the JS behaviour managed by Stimulus.
RSpec.describe Search::Filter::Pages, type: :system do
  let(:preview_path) { '/rails/components/search/filter/pages/' }

  describe 'with_no_pages' do
    before { visit preview_path.concat('with_no_pages') }

    it 'has a title' do
      expect(page).to have_css('.dropdown a.dropdown-toggle[href="#"]', text: 'PAGES')
    end

    it 'has no colored border' do
      expect(page).to have_css('.dropdown .btn-group.btn-group-fluid.border:not(.border-primary)')
    end

    it 'has content' do
      open_dropdown
      expect(page).to have_css('.dropdown-menu', text: 'Any')
      expect(page).not_to have_css('.dropdown-menu', text: 'Clear')
    end

    it 'updates content' do
      open_dropdown
      change_range_input('q_num_of_pages_gteq', 50)

      expect(page).to have_css('.dropdown .btn-group.btn-group-fluid.border.border-primary')
      expect(page).to have_css('.dropdown a.text-primary[href="#"]', text: 'PAGES: MIN. 50')
      expect(page).to have_css('.dropdown-menu', text: 'Min. 50')
      expect(page).to have_css('.dropdown-menu', text: 'Clear')

      expect(page).not_to have_css('.dropdown-menu', text: 'Any')
    end

    it 'updates content' do
      open_dropdown
      change_range_input('q_num_of_pages_lteq', 400)

      expect(page).to have_css('.dropdown .btn-group.btn-group-fluid.border.border-primary')
      expect(page).to have_css('.dropdown a.text-primary[href="#"]', text: 'PAGES: MAX. 400')
      expect(page).to have_css('.dropdown-menu', text: 'Max. 400')
      expect(page).to have_css('.dropdown-menu', text: 'Clear')

      expect(page).not_to have_css('.dropdown-menu', text: 'Any')
    end

    it 'updates content' do
      open_dropdown
      change_range_input('q_num_of_pages_gteq', 50)
      change_range_input('q_num_of_pages_lteq', 400)

      expect(page).to have_css('.dropdown .btn-group.btn-group-fluid.border.border-primary')
      expect(page).to have_css('.dropdown a.text-primary[href="#"]', text: 'PAGES: 50 - 400')
      expect(page).to have_css('.dropdown-menu', text: '50 - 400')
      expect(page).to have_css('.dropdown-menu', text: 'Clear')

      expect(page).not_to have_css('.dropdown-menu', text: 'Any')
    end

    def open_dropdown
      click_on('Pages')
    end
  end

  describe 'with_min_and_max_pages' do
    before { visit preview_path.concat('with_min_and_max_pages') }

    it 'has a title' do
      expect(page).to have_css('.dropdown a.text-primary[href="#"]', text: 'PAGES: 100 - 400')
    end

    it 'has a colored border' do
      expect(page).to have_css('.dropdown .btn-group.btn-group-fluid.border.border-primary')
    end

    it 'has content' do
      open_dropdown
      expect(page).to have_css('.dropdown-menu', text: '100 - 400')
      expect(page).to have_css('.dropdown-menu', text: 'Clear')

      expect(page).not_to have_css('.dropdown-menu', text: 'Any')
    end

    it 'resets content' do
      open_dropdown
      click_on 'Clear'

      expect(page).to have_css('.dropdown .btn-group.btn-group-fluid.border:not(.border-primary)')
      expect(page).to have_css('.dropdown a.dropdown-toggle[href="#"]', text: 'PAGES')
      expect(page).to have_css('.dropdown-menu', text: 'Any')

      expect(page).not_to have_css('.dropdown-menu', text: 'Clear')
    end

    it 'also resets content' do
      find('.dropdown-toggle-split').click
      click_on('Pages')

      expect(page).to have_css('.dropdown .btn-group.btn-group-fluid.border:not(.border-primary)')
      expect(page).to have_css('.dropdown a.dropdown-toggle[href="#"]', text: 'PAGES')
      expect(page).to have_css('.dropdown-menu', text: 'Any')

      expect(page).not_to have_css('.dropdown-menu', text: 'Clear')
    end

    def open_dropdown
      click_on('Pages: 100 - 400')
    end
  end

  def change_range_input(locator, value)
    find_field(locator).execute_script "this.value = #{value}; this.dispatchEvent(new Event('input'));"
  end
end
