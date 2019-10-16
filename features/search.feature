Feature:
  As a user
  I want to search for books

  @wip
  Scenario: Search on the home page
    When I open the application
    Then I can search

  Scenario: Search on the book page
    Given I open the application
    When I choose "Books" from the navigation drawer
    Then I can search

  Scenario: Search for keyword in title


  Scenario: Search for keyword in summary

  Scenario: Highlight keywords

  Scenario: Search for available books (Kabisa only)

  Scenario: Search for 'good' books
