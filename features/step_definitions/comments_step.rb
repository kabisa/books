Then("I see {int} comment(s)") do |comments_count|
  expect(page).to have_content(/#{comments_count} Comments?/)
  expect(page).to have_css('.comments li:not(.new-comment)', count: comments_count)
end

When("I comment with {string}") do |body|
  fill_in('comment[body]', with: body)
  click_on('Comment')
end


When("I delete the comment {string}") do |body|
  within('.comments li', text: body) do
    find('button', text: 'delete', visible: false).click
  end
end

Then("I {can_or_not}add a comment") do |should_do|
  to_have_or_not_have = should_do ? 'to' : 'not_to'
  within('.comments') do
    expect(page).send(to_have_or_not_have, have_css('form.new_comment'))
  end
end

