Feature:
  As a Kabisaan
  I want to delete a book
  So the application doesn't get polluted

  @javascript
  Scenario: Delete a book
    Given I signed in as a Kabisaan
    And the following e-books:
      | title                       | link                                  | summary                      |
      | Lorem Ipsum                 | http://www.kabisa.nl/lorem-ipsum.epub | Lorem ipsum dolor sit amet.  |
      | Dolor Sit                   | http://kabisa.nl/dolor-sit.pdf        | Consectetur adipiscing elit. |
      | consectetur adipiscing elit | http://kabisa.nl/consectetur.pdf      | Consectetur adipiscing elit. |
    And I choose "Books" from the navigation drawer
    When I delete the book "Lorem Ipsum"
    Then I see a list of 2 e-books

  @todo
  Scenario: Undo a deletion
