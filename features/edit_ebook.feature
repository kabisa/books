@javascript
Feature:
  As a Kabisaan
  I can edit a book
  So our books collection keeps up-to-date

  @wip
  Scenario: Create a book
    Given I signed in as a Kabisaan
    And the following locations:
      | city     |
      | Rome     |
    And the following printed book:
      | title       | location | copies |
      | Lorem Ipsum | Rome     | 1      |
    When I choose "Books" from the navigation drawer
    Then I can edit the book "Lorem Ipsum"
