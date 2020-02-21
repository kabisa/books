Then("I should be on my profile page") do
  expect(current_path).to eql('/profile')
end

