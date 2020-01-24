Feature:
  As a Kabisaan
  I can add a book
  So I can contribute to our books collection

  Background:
    Given the following locations:
      | city     |
      | Rome     |
      | Florence |
      | Sydney   |

  Scenario: Create a book with a printed copy
    Given I'm adding a new book
    When I populate the "Title" field with "Awesome Book"
    And I click "Save"
    Then I am viewing the book
    And it's a printed book
    And I am seeing the button for adding a new book

  @javascript
  Scenario: Create a printed book with printed copies on several locations
    Given I'm adding a new book
    When I populate the "Title" field with "Awesome Book"
    And I add 2 copies of the book to the location "Rome"
    And I add another location
    And I add 3 copies of the book to the location "Florence"
    And I click "Save"
    Then I see there are 5 copies of the book

  Scenario: Create an invalid book with a printed copy
    Given I'm adding a new book
    And I try to add an empty book
    Then I see a validation error for "Title"
    And I do not see a validation error for "Link"

  @javascript
  @wip
  Scenario: Create a book without printed copies
    Given I'm adding a new book
    When I populate the "Title" field with "Awesome Book"
    And I remove the first location
    And I click "Save"
    Then I see a validation error that download link is required in case no copies are added

  @javascript
  Scenario: Create a book with multiple copies on the same locations
    Given I'm adding a new book
    When I populate the "Title" field with "Awesome Book"
    And I add another location
    And I click "Save"
    Then I see a validation error that duplicate locations are not allowed
