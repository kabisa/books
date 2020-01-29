@javascript
Feature: As a Kabisaan
  I want to borrow a printed book
  So I can read it

  Scenario: Show `Borrow` button
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
    Then I can borrow "Lorem Ipsum"

  Scenario: Borrow a book
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
    And I borrow the book "Lorem Ipsum"
    Then I see the book "Lorem Ipsum" has 0 copies left
    And I see feedback about borrowing the book "Lorem Ipsum"
    And I cannot borrow "Lorem Ipsum"
    But I can return the book "Lorem Ipsum"

  Scenario: Show submenu when multiple copies
    Given I signed in as a Kabisaan
    And the following locations:
      | city     |
      | Rome     |
      | Florence |
    And the following book:
      | title       |
      | Lorem Ipsum |
    And the book "Lorem Ipsum" is available at the following locations:
      | location | copies |
      | Rome     | 1      |
      | Florence | 1      |
    When I choose "Books" from the navigation drawer
    And I borrow the book "Lorem Ipsum" from "Rome"
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
    And the following book:
      | title       |
      | Lorem Ipsum |
    And the book "Lorem Ipsum" is available at the following locations:
      | location | copies |
      | Rome     | 1      |
    And the following borrowings:
      | title       | location | user           |
      | Lorem Ipsum | Rome     | john@kabisa.nl |
    When I choose "Books" from the navigation drawer
    Then I cannot borrow "Lorem Ipsum"

  Scenario: Guests cannot borrow books
    Given the following locations:
      | city     |
      | Florence |
    And the following book:
      | title       |
      | Lorem Ipsum |
    And the book "Lorem Ipsum" is available at the following locations:
      | location | copies |
      | Florence | 1      |
    When I choose "Books" from the navigation drawer
    Then I cannot borrow "Lorem Ipsum"

  Scenario: Borrow a book from the show page
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
    And I expand the panel for "Lorem Ipsum"
    And I click "View Details"
    And I borrow the book
    Then I see the book has 0 copies left
    And I see feedback about borrowing the book "Lorem Ipsum"
    And I should not see a borrow button
    But I should see a return button

  @todo
  Scenario: Undo a borrow action
