@javascript
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

  Scenario: Create a book with a download link
    Given I'm adding a new book
    And I populate the "Title" field with "Awesome Book"
    And I populate the "Link" field with "http://www.kabisa.nl/awesome_book.epub"
    And I populate the "Summary" field with "Lorem ipsum dolor sit amet."
    And I add the writers "Stephen King, Charles Dickens"
    And I add the tags "programming, software"
    And I populate the "Number of pages" field with "500"
    And I select "2004-12-31" in the "Publish Date" datepicker
    And I click "Save"
    Then I am viewing the book
    And it's an e-book
    And I can edit the book
    And I am seeing the button for adding a new book

  Scenario: Create a book without a download link or printed copy
    Given I'm adding a new book
    And I remove the first location
    When I try to add an empty book
    Then I see a validation error for "Title"
    And I see a validation error for "Link"

  Scenario: Create a book with an invalid download link
    Given I'm adding a new book
    And I populate the "Title" field with "Awesome Book"
    And I populate the "Link" field with "this is an invalid link"
    And I click "Save"
    Then I see a validation error for "Link"

  Scenario: Create a book with a download link but no printed copies
    Given I'm adding a new book
    And I populate the "Title" field with "Awesome Book"
    And I populate the "Link" field with "http://www.kabisa.nl/awesome_book.epub"
    And I remove the first location
    And I click "Save"
    Then I am viewing the book
