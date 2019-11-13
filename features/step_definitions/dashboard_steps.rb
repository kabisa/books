Then("I see the book {string} suggested as {string}") do |title, suggestion|
  within('.card', text: suggestion) do
    expect(page).to have_content(title)
  end
end
