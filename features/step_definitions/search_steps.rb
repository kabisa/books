Then("I can search") do
  expect(page).to have_css('form input[type="search"]')
end

When("I search for {string}") do |q|
  within('form.book_search') do
    find('input[type="search"]').set(q)
    click_on('Search')
  end
end

When("I search for books with at least {int} likes") do |likes_count|
  within('form.book_search') do
    click_on('Likes')
    js = <<-JS
      var event = new Event('input')
      var element = document.getElementById("q_likes_count_gteq")
      element.value = #{likes_count}
      element.dispatchEvent(event)
    JS
    page.execute_script js
    find('.dropdown-menu.show').click_on('×')
    click_on('Search')
  end
end


When("I search for books tagged with {string}") do |text|
  within('form.book_search') do
    click_on('Tags')

    tags = text.split(/\s*,\s*/)

    within('.tags') do
      tags.each do |tag|
        find('label', text: tag).click
      end
    end

    find('.dropdown-menu.show').click_on('×')
    click_on('Search')
  end
end

When("I search for books between {int} and {int} pages") do |at_least, at_most|
  within('form.book_search') do
    click_on('Pages')

    js = <<-JS
      var event = new Event('input')
      var atLeastEl = document.getElementById("q_num_of_pages_gteq")
      atLeastEl.value = #{at_least}
      atLeastEl.dispatchEvent(event)

      var atMostEl = document.getElementById("q_num_of_pages_lteq")
      atMostEl.value = #{at_most}
      atMostEl.dispatchEvent(event)
    JS
    page.execute_script js
    find('.dropdown-menu.show').click_on('×')
    click_on('Search')
  end
end


When("I search for books that were published between {int} and {int} years ago") do |at_least, at_most|
  within('form.book_search') do
    click_on('Publication')

    js = <<-JS
      var event = new Event('input')
      var atLeastEl = document.getElementById("q_published_years_ago_lteq")
      atLeastEl.value = #{at_least}
      atLeastEl.dispatchEvent(event)

      var atMostEl = document.getElementById("q_published_years_ago_gteq")
      atMostEl.value = #{at_most}
      atMostEl.dispatchEvent(event)
    JS
    page.execute_script js
    find('.dropdown-menu.show').click_on('×')
    click_on('Search')
  end
end

Then("I see {string} is highlighted for the book {string}") do |q, title|
  within('.list-group-item', text: title) do
    expect(page).to have_css('mark', text: q)
  end
end

Then("I see that no results are found") do
  step %q(I should see a list of 0 books)
  expect(page).to have_content('No books found.')
  expect(page).to have_link('Clear all filters')
end


Then("I see the search form displaying {string}") do |text|
  within('form.book_search') do
    expect(page).to have_css('.filter-button', text: /#{text}/i)
  end
end
