Feature:
  As a user
  I can retrieve a list of books
  so I can decide which one to read next

  @javascript
  Scenario: List books
    Given there are 5 e-books
    When I choose "Books" from the navigation drawer
    Then I see a list of 5 books

  @javascript
  Scenario: List e-books and printed books
    Given there are 3 e-books
    And there are 5 printed books
    When I choose "Books" from the navigation drawer
    Then I see a list of 3 e-books
    And I see 3 download links
    And I see a list of 5 printed books

  @todo
  Scenario: Empty state
