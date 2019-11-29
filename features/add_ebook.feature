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

  @javascript
  @wip
  Scenario: Create a book
    Given I'm adding a new book
    And I populate the "Title" field with "Awesome Book"
    And I populate the "Link" field with "http://www.kabisa.nl/awesome_book.epub"
    And I populate the "Summary" field with "Lorem ipsum dolor sit amet."
    And I add the writers "Stephen King, Charles Dickens"
    And I add the tags "programming, software"
    And I click "Save"
    Then I am viewing the book
    And it's an e-book
    And I can edit the book
    And I am seeing the button for adding a new book

  Scenario: Create an invalid e-book
    Given I'm adding a new book
    When I try to add an empty book
    Then I see a validation error for "Title"
    And I see a validation error for "Link"

  Scenario: Create an e-book with an invalid link
    Given I'm adding a new book
    And I populate the "Title" field with "Awesome Book"
    And I populate the "Link" field with "this is an invalid link"
    And I click "Save"
    Then I see a validation error for "Link"

  @javascript
  Scenario: Invalid copies are ignored when saving ebook
    Given I'm adding a new book
    And I populate the "Title" field with "Awesome Book"
    And I populate the "Link" field with "http://www.kabisa.nl/awesome_book.epub"
    And I toggle "Type" to "Printed book"
    And I remove the first location
    When I toggle "Type" to "E-book"
    And I click "Save"
    Then I am viewing the book
