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

  Scenario: Remove a re-edition
    Given I signed in as a Kabisaan
    And the following books:
      | title       | link                                  | reedition |
      | Dolor Sit   | http://kabisa.nl/dolor-sit.pdf        |           |
      | Lorem Ipsum | http://www.kabisa.nl/lorem-ipsum.epub | Dolor Sit |
    When I choose "Books" from the navigation drawer
    And I edit the book "Lorem Ipsum"
    And I type "" into the "Re-edition" field
    And I click "Save"
    Then I should not see a link to a re-edition
    When I choose "Books" from the navigation drawer
    And I expand the panel for "Lorem Ipsum"
    Then I should not see a link to a re-edition for "Lorem Ipsum"

  Scenario: Add an invalid re-edition
    Given I signed in as a Kabisaan
    And the following books:
      | title       | link                                  | reedition |
      | Dolor Sit   | http://kabisa.nl/dolor-sit.pdf        |           |
      | Lorem Ipsum | http://www.kabisa.nl/lorem-ipsum.epub | Dolor Sit |
    When I choose "Books" from the navigation drawer
    And I edit the book "Lorem Ipsum"
    And I type "Invalid re-edition" into the "Re-edition" field
    And I click "Save"
    Then I see a validation error for "Re-edition"

  Scenario: See the latest version
    And the following books:
      | title                  | link                                  | reedition   |
      | Dolor Sit              | http://kabisa.nl/dolor-sit.pdf        |             |
      | Lorem Ipsum            | http://www.kabisa.nl/lorem-ipsum.epub | Dolor Sit   |
      | Consectetur Adipiscing | http://kabisa.nl/consectetur/         | Lorem Ipsum |
    When I choose "Books" from the navigation drawer
    Then I should see that the book "Dolor Sit" is the latest version
    But I should not see that the book "Lorem Ipsum" is the latest version
