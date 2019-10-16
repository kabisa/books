Feature:
  As a user
  I want to search for books

  Scenario: Search on the home page
    When I open the application
    Then I can search

  @wip
  Scenario: Search on the book page
    Given I open the application
    When I choose "Books" from the navigation drawer
    Then I can search

  @todo
  Scenario: Search for keyword in title


  @todo
  Scenario: Search for keyword in summary

  @todo
  Scenario: Highlight keywords

  @todo
  Scenario: Search for available books (Kabisa only)

  @todo
  Scenario: Search for 'good' books
