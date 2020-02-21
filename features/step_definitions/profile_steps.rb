Then("I should be on my profile page") do
  expect(current_path).to eql('/profile')
end

Given("I am on my profile page") do
  step %q(I open the application)
  step %q(I choose "Profile" from the account menu)
end

When("I exit my profile page") do
  step %q(I navigate back)
end

Then("I should be on the books page") do
  expect(current_path).to eql('/books')
end
