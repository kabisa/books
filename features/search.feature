Feature:
  As a user
  I want to search for books

  Background:
    Given the following e-books:
      | title                  | link                                  | summary                         | tag_list              |
      | Lorem Ipsum            | http://www.kabisa.nl/lorem-ipsum.epub | Lorem ipsum dolor sit amet.     | programming           |
      | Dolor Sit              | http://kabisa.nl/dolor-sit.pdf        | Consectetur adipiscing elit.    | software              |
      | Consectetur Adipiscing | http://kabisa.nl/consectetur/         | Sed convallis metus eget felis. | unknown               |
      | Morbi ullamcorper      | http://kabisa.nl/morbi/               | Duis aliquam nulla felis.       | programming, software |

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
    Then I see a list of 4 books

  @todo
  Scenario: Search for available books (Kabisa only)

  @javascript
  Scenario: Search for 'good' books
    Given the following users:
      | email              |
      | marty@kabisa.nl    |
      | emmett@kabisa.nl   |
      | lorraine@kabisa.nl |
      | george@kabisa.nl   |
      | biff@kabisa.nl     |
    And the following votes:
      | title       | liked by                                                         |
      | Lorem Ipsum | marty@kabisa.nl emmett@kabisa.nl george@kabisa.nl biff@kabisa.nl |
    When I open the application
    And I search for books with at least 4 likes
    Then I see a list of 1 book

  @javascript
  Scenario: Search for tagged books
    And the following votes:
      | title       | liked by                                                         |
      | Lorem Ipsum | marty@kabisa.nl emmett@kabisa.nl george@kabisa.nl biff@kabisa.nl |
    When I open the application
    And I search for books tagged with "software, programming"
    Then I see a list of 3 books
