require 'rails_helper'

# This tests uses the preview located in spec/components/previews...
# and test the JS behaviour managed by Stimulus.
RSpec.describe Search::Filter::Publication, type: :system do
  let(:preview_path) { '/rails/components/search/filter/publication/' }

  describe 'with_no_publication_date' do
    before { visit preview_path.concat('with_no_publication_date') }

    it 'has a title' do
      expect(page).to have_css('.dropdown a.dropdown-toggle[href="#"]', text: 'PUBLICATION')
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
      change_range_input('q_published_years_ago_lteq', 4)

      expect(page).to have_css('.dropdown .btn-group.btn-group-fluid.border.border-primary')
      expect(page).to have_css('.dropdown a.text-primary[href="#"]', text: 'OLDER THAN 4 YR.')
      expect(page).to have_css('.dropdown-menu', text: 'Older than 4 yr.')
      expect(page).to have_css('.dropdown-menu', text: 'Clear')

      expect(page).not_to have_css('.dropdown-menu', text: 'Any')
    end

    it 'updates content' do
      open_dropdown
      change_range_input('q_published_years_ago_gteq', 4)

      expect(page).to have_css('.dropdown .btn-group.btn-group-fluid.border.border-primary')
      expect(page).to have_css('.dropdown a.text-primary[href="#"]', text: 'NEWER THAN 4 YR.')
      expect(page).to have_css('.dropdown-menu', text: 'Newer than 4 yr.')
      expect(page).to have_css('.dropdown-menu', text: 'Clear')

      expect(page).not_to have_css('.dropdown-menu', text: 'Any')
    end

    it 'updates content' do
      open_dropdown
      change_range_input('q_published_years_ago_lteq', 4)
      change_range_input('q_published_years_ago_gteq', 8)

      expect(page).to have_css('.dropdown .btn-group.btn-group-fluid.border.border-primary')
      expect(page).to have_css('.dropdown a.text-primary[href="#"]', text: 'PUBLISHED 4 - 8 YR. AGO')
      expect(page).to have_css('.dropdown-menu', text: 'Published 4 - 8 yr. ago')
      expect(page).to have_css('.dropdown-menu', text: 'Clear')

      expect(page).not_to have_css('.dropdown-menu', text: 'Any')
    end

    def open_dropdown
      click_on('Publication')
    end
  end

  describe 'with_min_and_max_publication_date' do
    before { visit preview_path.concat('with_min_and_max_publication_date') }

    it 'has a title' do
      expect(page).to have_css('.dropdown a.text-primary[href="#"]', text: 'PUBLISHED 2 - 8 YR. AGO')
    end

    it 'has a colored border' do
      expect(page).to have_css('.dropdown .btn-group.btn-group-fluid.border.border-primary')
    end

    it 'has content' do
      open_dropdown
      expect(page).to have_css('.dropdown-menu', text: 'Published 2 - 8 yr. ago')
      expect(page).to have_css('.dropdown-menu', text: 'Clear')

      expect(page).not_to have_css('.dropdown-menu', text: 'Any')
    end

    it 'resets content' do
      open_dropdown
      click_on 'Clear'

      expect(page).to have_css('.dropdown .btn-group.btn-group-fluid.border:not(.border-primary)')
      expect(page).to have_css('.dropdown a.dropdown-toggle[href="#"]', text: 'PUBLICATION')
      expect(page).to have_css('.dropdown-menu', text: 'Any')

      expect(page).not_to have_css('.dropdown-menu', text: 'Clear')
    end

    it 'also resets content' do
      find('.dropdown-toggle-split').click
      click_on('Publication')

      expect(page).to have_css('.dropdown .btn-group.btn-group-fluid.border:not(.border-primary)')
      expect(page).to have_css('.dropdown a.dropdown-toggle[href="#"]', text: 'PUBLICATION')
      expect(page).to have_css('.dropdown-menu', text: 'Any')

      expect(page).not_to have_css('.dropdown-menu', text: 'Clear')
    end

    def open_dropdown
      click_on('Published 2 - 8 yr. ago')
    end
  end

  def change_range_input(locator, value)
    find_field(locator).execute_script "this.value = #{value}; this.dispatchEvent(new Event('input'));"
  end
end
