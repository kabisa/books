Then("I see {int} comment(s)") do |comments_count|
  expect(page).to have_content(/#{comments_count} Comments?/)
  expect(page).to have_css('.comments li:not(.new-comment)', count: comments_count)
end

When("I comment with {string}") do |body|
  fill_in('comment[body]', with: body)
  click_on('Comment')
end

When("I delete the comment {string}") do |body|
  find('.comments li', text: body).hover

  within('.comments li', text: body) do
    find('button', text: 'delete').click
  end
end

Then("I {can_or_not}add a comment") do |should_do|
  to_have_or_not_have = should_do ? 'to' : 'not_to'
  within('.comments') do
    expect(page).send(to_have_or_not_have, have_css('form.new_comment'))
  end
end

Then("I see {int} comments for the book {string}") do |int, title|
  step %Q(I see "mode_comment #{int}" for the book "#{title}")
end

Then("I should see {int} comment by me") do |comments_count|
  step %Q(I should see #{comments_count} comment by "#{@user.email}")
end

Then("I should see {int} comment by {string}") do |comments_count, user_email|
  expect(page).to have_css('.comments li:not(.new-comment)', count: comments_count, text: user_email)
end

Given("I would like to comment anonymously") do
  unless @user.comments_anonymously?
    step %q(I am on my profile page)
    step %q(I toggle the "Post comments anonymously" switch)
    step %q(I click "Save")
  end
end

Then("I should see {int} anonymous comment") do |comments_count|
  expect(page).to have_css('.comments li:not(.new-comment)', count: comments_count, text: 'anonymous')
end
