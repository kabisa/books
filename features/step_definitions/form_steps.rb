Given("I populate the {string} field with {string}") do |label, value|

  label_to_placeholder_mapping = {
    'Title' => 'book_title',
    'Link' => 'book_link',
    'Summary' => 'book_summary',
    'Number of pages' => 'book_num_of_pages',
    'Publish Date' => 'book_published_on'
  }

  fill_in label_to_placeholder_mapping[label], with: value
end

Given("I select {string} in the {string} datepicker") do |value, label|
  label_to_placeholder_mapping = {
    'Publish Date' => 'book_published_on'
  }

  id = label_to_placeholder_mapping[label]

  # We only test if the datepicker is showing...
  find_field(id: id).click
  expect(page).to have_css('.picker-frame')

  # then we close it
  find('.picker').click
  # and set the value with some JS
  # (instead of selecting the proper date via the datepicker)
  page.execute_script("$('##{id}').val('#{value}')")
end

Given("I fill in {string} with {string}") do |locator, value|
  fill_in locator, with: value
end

When("I type {string} into the {string} field") do |value, locator|
  step %Q(I fill in "#{locator}" with "#{value}")
end

When("I select {string} as {string}") do |value, name|
  choose value
end

When("I add the tags {string}") do |text|
  tags = text.split(/\s*,\s*/)

  tags.each do |tag|
    within('form .book_tag_list') do
      el = find('.tagify__input')
      el.set("#{tag}\n")
      el.send_keys(:enter)
    end
  end
end

Given("I add the writers {string}") do |text|
  tags = text.split(/\s*,\s*/)

  tags.each do |tag|
    within('form .book_writer_names') do
      el = find('.tagify__input')
      el.set("#{tag}\n")
      el.send_keys(:enter)
    end
  end
end

When("I toggle the {string} switch") do |label|
  find('label', text: label).click
end

Then("I {do_or_not}see a validation error (for ){string}") do |should_do, label|
  within('form') do
    to_have_or_not_have = should_do ? 'to' : 'not_to'
    expect(page).send(to_have_or_not_have, have_css('.form-group.form-group-invalid', text: label))
  end
end

When("I choose {string} from the {string} autocomplete list") do |value, locator|
  # Take some time to process the `fetch` call.
  sleep 0.1
  within('ul.autocomplete-result-list') do
    find('li', text: value).click
  end
end
