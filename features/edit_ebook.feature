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
    And the following printed book:
      | title       | location | copies |
      | Lorem Ipsum | Rome     | 1      |
    When I choose "Books" from the navigation drawer
    Then I can edit "Lorem Ipsum"

  @wip
  Scenario: Edit a book
    Given I signed in as a Kabisaan
    And the following locations:
      | city     |
      | Rome     |
    And the following printed book:
      | title       | location | copies |
      | Lorem Ipsum | Rome     | 1      |
    When I choose "Books" from the navigation drawer
    And I edit the book "Lorem Ipsum"
    And I fill in "Title" with "Awesome Book"
    And I click "Save"
    Then I am viewing the book
