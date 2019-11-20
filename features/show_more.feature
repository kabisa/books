@javascript
Feature: Show more
  As a user
  I want to see a limit number of books per page

  Scenario: See first 10 books
    Given there are 25 books
    When I choose "Books" from the navigation drawer
    Then I see a list of 10 book

  Scenario: See the next 10 books
    Given there are 25 books
    And I choose "Books" from the navigation drawer
    When I click "More books"
    Then I see a list of 20 book

  @wip
  Scenario: See all books
    Given there are 25 books
    And I choose "Books" from the navigation drawer
    When I click "More books"
    When I click "More books"
    Then I see a list of 25 book
    And there are no more books to be shown
