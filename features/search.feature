Feature:
  As a user
  I want to search for books

  Background:
    Given the following e-books:
      | title       | link                                  | summary                      |
      | Lorem Ipsum | http://www.kabisa.nl/lorem-ipsum.epub | Lorem ipsum dolor sit amet.  |
      | Dolor Sit   | http://kabisa.nl/dolor-sit.pdf        | Consectetur adipiscing elit. |

  Scenario: Search on the home page
    When I open the application
    Then I can search

  Scenario: Search on the book page
    When I choose "Books" from the navigation drawer
    Then I can search

  Scenario: Search for keyword in title
    Given I open the application
    When I search for "ipsum"
    Then I see a list of 1 book

  Scenario: Search for keyword in summary
    Given I open the application
    When I search for "dolor sit"
    Then I see a list of 2 books

  Scenario: Highlight keywords
    Given I open the application
    When I search for "dolor sit"
    Then I see "dolor sit" is highlighted for the book "Lorem Ipsum"
    And I see "Dolor Sit" is highlighted for the book "Dolor Sit"

  Scenario: No search results
    Given I open the application
    When I search for "foo bar"
    Then I see that no results are found

  Scenario: Clear filter
    Given I open the application
    And I search for "foo bar"
    When I click "Clear all filters"
    Then I see a list of 2 books

  @todo
  Scenario: Search for available books (Kabisa only)

  @todo
  Scenario: Search for 'good' books

