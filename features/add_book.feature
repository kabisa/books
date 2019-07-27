Feature:
  As a Kabisaan
  I can add a book
  So I can contribute to our books collection

  Scenario: Add first book
    Given I signed in as a Kabisaan
    When I click the "add" button
    Then I am adding a new book
    But I am not seeing the button for adding a new book

  Scenario: Create a book
    Given I'm adding a new book
    When I fill in "Title" with "Awesome Book"
    And I click "Save"
    Then I am viewing the book
    And I can edit the book
    Then I am seeing the button for adding a new book

  Scenario: Create an invalid book
    Given I'm adding a new book
    When I try to add an empty book
    Then I see a validation error for "Title"

  @todo
  Scenario: Guest cannot add a book
