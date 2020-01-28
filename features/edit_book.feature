@javascript
Feature:
  As a Kabisaan
  I can edit a book
  So our books collection keeps up-to-date

  Scenario: Can edit a book
    Given I signed in as a Kabisaan
    And the following locations:
      | city     |
      | Rome     |
    And the following book:
      | title       |
      | Lorem Ipsum |
    When I choose "Books" from the navigation drawer
    Then I can edit "Lorem Ipsum"

  Scenario: Edit a book
    Given I signed in as a Kabisaan
    And the following locations:
      | city     |
      | Rome     |
    And the following book:
      | title       |
      | Lorem Ipsum |
    When I choose "Books" from the navigation drawer
    And I edit the book "Lorem Ipsum"
    And I populate the "Title" field with "Awesome Book"
    And I click "Save"
    Then I am viewing the book "Awesome Book"

  Scenario: Edit a book without a download link or printed copy
    Given I signed in as a Kabisaan
    And the following locations:
      | city     |
      | Rome     |
    And the following book:
      | title       |
      | Lorem Ipsum |
    And the book "Lorem Ipsum" is available at the following locations:
      | location | copies |
      | Rome     | 1      |
    When I choose "Books" from the navigation drawer
    And I edit the book "Lorem Ipsum"
    And I remove the first location
    And I populate the "Link" field with ""
    And I click "Save"
    Then I see a validation error that download link is required in case no copies are added
