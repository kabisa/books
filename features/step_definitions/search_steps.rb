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
    click_on('Search')
  end
end

Then("I see {string} is highlighted for the book {string}") do |q, title|
  within('.list-group-item', text: title) do
    expect(page).to have_css('mark', text: q)
  end
end

Then("I see that no results are found") do
  step %q(I see a list of 0 books)
  expect(page).to have_content('No books found.')
  expect(page).to have_link('Clear all filters')
end
