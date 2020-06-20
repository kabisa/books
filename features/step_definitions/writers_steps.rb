Given('there are {int} writers with books') do |writers_count|
  create_list :writer, writers_count, :with_books
end

Given('there are {int} writers without books') do |writers_count|
  create_list :writer, writers_count
end

When('I click on the card for writer {string}') do |writer_name|
  find('.card', text: writer_name).click
end

Then('I should see {int} cards with writers') do |writers_count|
  within('.card-grid') do
    expect(page).to have_css('.card', count: writers_count)
  end
end

Then('there are no more writers to be shown') do
  within('.card-grid') do
    expect(page).not_to have_css('a', text: 'More writers')
  end
end
