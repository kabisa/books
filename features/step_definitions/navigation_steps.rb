Given('I open the application') { visit '/' }

Given('I navigate to page for adding a new book') { visit(new_book_path) }

When('I choose {string} from the navigation drawer') do |menu|
  step 'I open the application'
  find('nav button.navbar-toggler').click

  within('.navdrawer-nav') do
    # Menu items also contain an icon that are displayed as text
    # so we need to use a regex.
    find('a', text: /#{menu}/).click
  end
end

When('I choose {string} from the account menu') do |string|
  within('nav') do
    click_on @user.email
    click_on 'Profile'
  end
end

When('I navigate back') { within('nav.navbar') { click_on 'arrow_back' } }

When('I scroll to the bottom of the page') do
  script = <<-JS
  window.scrollTo(0, document.body.scrollHeight);
  JS

  page.execute_script(script)
  sleep 0.5
end
