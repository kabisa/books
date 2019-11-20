@javascript
Feature: Show more
  As a user
  I want to see a limit number of books per page

  Scenario: See first 10 books
    Given there are 25 books
    When I choose "Books" from the navigation drawer
    Then I see a list of 10 book

  @wip
  Scenario: See the next 10 books
    Given I have 25 books
    And I open the application
    When I click "More"
    Then I see a list of 20 book

  @todo
  Scenario: See all books
    Given I have 25 books
    And I open the application
    When I click "More"
    And I click "More"
    Then I see a list of 25 book
    But I don't see the "More" link
