@javascript
Feature: Re-edition
  As a user
  I want to see if there's a newer version of a book in the library
  So that I'm sure I'm not reading an outdated version

  Scenario: Add a re-edition
    Given the following locations:
      | city     |
      | Rome     |
    And the following books:
      | title                       | link                                  |
      | Lorem Ipsum                 | http://www.kabisa.nl/lorem-ipsum.epub |
    When I'm adding a new book
    And I populate the "Title" field with "A Re-edition"
    And I type "Lorem" into the "Re-edition" field
    And I choose "Lorem Ipsum" from the "Reedition" autocomplete list
    And I click "Save"
    Then I should see a link to a re-edition
    When I choose "Books" from the navigation drawer
    And I expand the panel for "A Re-edition"
    Then I should see a link to a re-edition for "A Re-edition"

  @wip
  Scenario: Remove a re-edition
    Given I signed in as a Kabisaan
    And the following books:
      | title       | link                                  | reedition |
      | Lorem Ipsum | http://www.kabisa.nl/lorem-ipsum.epub | Dolor Sit |
      | Dolor Sit   | http://kabisa.nl/dolor-sit.pdf        |           |
    When I choose "Books" from the navigation drawer
    And I edit the book "Lorem Ipsum"
    And I type "" into the "Re-edition" field
    And I click "Save"
    Then I should not see a link to a re-edition

  @todo
  Scenario: Add an invalid re-edition

  @todo
  Scenario: View re-edition on a collapsed book item

  @todo
  Scenario: View re-edition on an expanded book item
