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

  Scenario: Create a printed book
    Given I'm adding a new book
    When I fill in "Title" with "Awesome Book"
    And I toggle "Type" to "Printed book"
    And I click "Save"
    Then I am viewing the book
    And it's a printed book
    And I am seeing the button for adding a new book

  @javascript
  Scenario: Create a printed book with copies on several locations
    Given I'm adding a new book
    When I fill in "Title" with "Awesome Book"
    And I toggle "Type" to "Printed book"
    And I add 2 copies of the book to the location "Rome"
    And I add another location
    And I add 3 copies of the book to the location "Florence"
    And I click "Save"
    Then I see there are 5 copies of the book

  Scenario: Create an invalid printed book
    Given I'm adding a new book
    When I toggle "Type" to "Printed book"
    And I try to add an empty book
    Then I see a validation error for "Title"
    And I do not see a validation error for "Link"

  @javascript
  Scenario: Create a printed book without copies
    Given I'm adding a new book
    When I fill in "Title" with "Awesome Book"
    And I toggle "Type" to "Printed book"
    And I remove the first location
    And I click "Save"
    Then I see a validation error that at least 1 location is required

  @javascript
  Scenario: Create a printed book with duplicate locations
    Given I'm adding a new book
    When I fill in "Title" with "Awesome Book"
    And I toggle "Type" to "Printed book"
    And I add another location
    And I click "Save"
    Then I see a validation error that duplicate locations are not allowed
