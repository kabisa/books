@javascript
Feature: As a Kabisaan
  I want to borrow a printed book
  So I can read it

  Scenario: Show `Borrow` button
    Given I signed in as a Kabisaan
    And the following locations:
      | city     |
      | Rome     |
    And I have the following printed book:
      | title       | location | copies |
      | Lorem Ipsum | Rome     | 1      |
    When I choose "Books" from the navigation drawer
    Then I can borrow "Lorem Ipsum"

  Scenario: Borrow a book
    Given I signed in as a Kabisaan
    And the following locations:
      | city     |
      | Rome     |
    And I have the following printed book:
      | title       | location | copies |
      | Lorem Ipsum | Rome     | 1      |
    When I choose "Books" from the navigation drawer
    And I borrow the book "Lorem Ipsum"
    Then I see the book "Lorem Ipsum" has 0 copies left
    And I cannot borrow "Lorem Ipsum"
    But I can return the book "Lorem Ipsum"

  Scenario: Show dialog when multiple copies
    Given I signed in as a Kabisaan
    And the following locations:
      | city     |
      | Rome     |
      | Florence |
    And I have the following printed book:
      | title       | location | copies |
      | Lorem Ipsum | Rome     | 1      |
      | Lorem Ipsum | Florence | 1      |
    When I choose "Books" from the navigation drawer
    And I borrow the book "Lorem Ipsum"
    And I choose the location "Rome" in the modal
    And I click "Borrow" in the modal
    Then I see the book "Lorem Ipsum" has 1 copy left
    And I cannot borrow "Lorem Ipsum"
    But I can return the book "Lorem Ipsum"

  Scenario: Unable to borrow if all copies are gone
    Given I signed in as a Kabisaan
    And the following locations:
      | city     |
      | Rome     |
    And the following users:
      | email          |
      | john@kabisa.nl |
    And I have the following printed book:
      | title       | location | copies |
      | Lorem Ipsum | Rome     | 1      |
    And I have the following borrowings:
      | title       | location | user           |
      | Lorem Ipsum | Rome     | john@kabisa.nl |
    When I choose "Books" from the navigation drawer
    Then I cannot borrow "Lorem Ipsum"

  Scenario: Guests cannot borrow books
    Given the following locations:
      | city     |
      | Florence |
    And I have the following printed book:
      | title       | location | copies |
      | Lorem Ipsum | Florence | 1      |
    When I choose "Books" from the navigation drawer
    Then I cannot borrow "Lorem Ipsum"

  @todo
  Scenario: Undo a borrow action
