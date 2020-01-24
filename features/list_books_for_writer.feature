Feature:
  As a user
  I want to see all books for a specific writer

  @javascript
  Scenario: Show all books for a specific writer
    Given the following books:
      | title                  | link                                  |  writer_names                  |
      | Lorem Ipsum            | http://www.kabisa.nl/lorem-ipsum.epub |  Stephen King, Charles Dickens |
      | Dolor Sit              | http://kabisa.nl/dolor-sit.pdf        |  Stephen Hawking               |
      | Consectetur Adipiscing | http://kabisa.nl/consectetur/         |  Mark Twain, Stephen King      |
      | Morbi ullamcorper      | http://kabisa.nl/morbi/               |  Charles Dickens, Mark Twain   |
    Given I open the application
    And I search for "Consectetur"
    When I click on the writer "Stephen King" for the book "Consectetur Adipiscing"
    Then I should see a list of 2 books
