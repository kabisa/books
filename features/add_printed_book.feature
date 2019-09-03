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
    But I cannot download the book
    And it's a printed book
    And I am seeing the button for adding a new book

  Scenario: Create an invalid printed book
    Given I'm adding a new book
    When I toggle "Type" to "Printed book"
    And I try to add an empty book
    Then I see a validation error for "Title"
    And I do not see a validation error for "Link"
