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

  Scenario: Add first book
    Given I signed in as a Kabisaan
    When I click the "add" button
    Then I am adding a new book
    But I am not seeing the button for adding a new book

  Scenario: Create a book
    Given I'm adding a new book
    When I fill in "Title" with "Awesome Book"
    And I fill in "Link" with "http://www.kabisa.nl/awesome_book.epub"
    And I click "Save"
    Then I am viewing the book
    And I can download the book
    And I can edit the book
    And I am seeing the button for adding a new book

  Scenario: Create a printed book
    Given I'm adding a new book
    When I fill in "Title" with "Awesome Book"
    And I toggle "Type" to "Printed book"
    And I click "Save"
    Then I am viewing the book
    But I cannot download the book
    And it's a printed book
    And I am seeing the button for adding a new book

  Scenario: Create an invalid e-book
    Given I'm adding a new book
    When I try to add an empty book
    Then I see a validation error for "Title"
    And I see a validation error for "Link"

  Scenario: Create an e-book with an invalid link
    Given I'm adding a new book
    When I fill in "Title" with "Awesome Book"
    And I fill in "Link" with "this is an invalid link"
    And I click "Save"
    Then I see a validation error for "Link"

  @javascript
  Scenario: Toggle book type properties
    Given I'm adding a new book
    Then I see attributes for an e-book
    And I do not see attributes for a printed book
    When I toggle "Type" to "Printed book"
    Then I do not see attributes for an e-book
    But I see attributes for a printed book

  Scenario: Create an invalid printed book
    Given I'm adding a new book
    When I toggle "Type" to "Printed book"
    And I try to add an empty book
    Then I see a validation error for "Title"
    And I do not see a validation error for "Link"

  Scenario: Guest cannot add a book
    Given I did not sign in
    When I navigate to page for adding a new book
    Then I see an error telling me I am not unauthorized
    And I'm back on the main page

