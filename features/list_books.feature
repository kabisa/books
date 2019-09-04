@javascript
Feature:
  As a user
  I can retrieve a list of books
  so I can decide which one to read next

  Scenario: List books
    Given there are 5 e-books
    When I choose "Books" from the navigation drawer
    Then I see a list of 5 books

  Scenario: List e-books and printed books
    Given there are 3 e-books
    And there are 5 printed books
    When I choose "Books" from the navigation drawer
    Then I see a list of 3 e-books
    And I see a list of 5 printed books

  Scenario: List e-books for guests
    Given there are 3 e-books
    And there are 5 printed books
    When I choose "Books" from the navigation drawer
    And I see 0 download links

  Scenario: List printed books for guests
    Given there are 5 printed books
    When I choose "Books" from the navigation drawer
    Then I see a list of 5 printed books
    But I do not see information about how many copies there are

  Scenario: List e-books for authorized users
    Given I signed in as a Kabisaan
    And there are 3 e-books
    And there are 5 printed books
    When I choose "Books" from the navigation drawer
    Then I see 3 download links

  Scenario: List printed books authorized users
    Given I signed in as a Kabisaan
    And there are 5 printed books
    When I choose "Books" from the navigation drawer
    Then I see a list of 5 printed books
    And I see information about how many copies there are

  @todo
  Scenario: Empty state
