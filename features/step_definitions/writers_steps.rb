When('I click on the card for writer {string}') do |writer_name|
  find('.card', text: writer_name).click
end

Then('I should see {int} cards with writers') do |writers_count|
  within('.card-deck') do
    expect(page).to have_css('.card', count: writers_count)
  end
end
