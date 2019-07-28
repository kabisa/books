Feature:
  As a user
  I can retrieve a list of books
  so I can decide which one to read next

  @javascript
  Scenario: List books
    Given there are 5 books
    When I choose "Books" from the navigation drawer
    Then I see a list of 5 books

  @todo
  Scenario: Empty state
