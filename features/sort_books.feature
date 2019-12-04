@javascript
Feature: Sort books
  As a user
  I want to see the books sorted by title

  Background:
    Given the following e-books:
      | title                  | link                                  |
      | Lorem Ipsum            | http://www.kabisa.nl/lorem-ipsum.epub |
      | Dolor Sit              | http://kabisa.nl/dolor-sit.pdf        |
      | Morbi ullamcorper      | http://kabisa.nl/morbi/               |
      | Consectetur Adipiscing | http://kabisa.nl/consectetur/         |
    Given the following users:
      | email              |
      | marty@kabisa.nl    |
      | emmett@kabisa.nl   |
      | lorraine@kabisa.nl |
      | george@kabisa.nl   |
      | biff@kabisa.nl     |
    And the following votes:
      | title                  | liked by                         | disliked by                                         |
      | Lorem Ipsum            | marty@kabisa.nl                  |marty@kabisa.nl emmett@kabisa.nl lorraine@kabisa.nl |
      | Morbi ullamcorper      | marty@kabisa.nl emmett@kabisa.nl |                                                     |
      | Consectetur Adipiscing | lorraine@kabisa.nl               |                                                     |

  Scenario: Sort on title by default
    When I choose "Books" from the navigation drawer
    Then I see "Consectetur Adipiscing" as the first book
    And I see "Morbi ullamcorper" as the last book

  @wip
  Scenario: Sort on number of likes
    When I choose "Books" from the navigation drawer
    And I sort on "Most-liked"
    And I see "Morbi ullamcorper" as the first book
    Then I see "Dolor Sit" as the last book

