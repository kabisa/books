Feature:
  As a Kabisaan
  I can add a book
  So I can contribute to our books collection

  Scenario: Add first book
    Given I signed in as a Kabisaan
    When I click the "add" button
    Then I can add a new book

  @todo
  Scenario: Create a book

  @todo
  Scenario: Create an invalid book

  @todo
  Scenario: Guest cannot add a book
