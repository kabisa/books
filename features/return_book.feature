@javascript
Feature: As a Kabisaan
  I want to return a borrowed book
  So someone else can read it

  Scenario: Return a borrowed book
    Given I signed in as a Kabisaan
    And the following locations:
      | city     |
      | Rome     |
    And the following printed book:
      | title       | location | copies |
      | Lorem Ipsum | Rome     | 1      |
    And I borrowed the book "Lorem Ipsum" 10 days ago
    When I choose "Books" from the navigation drawer
    And I return the book "Lorem Ipsum"
    Then I see the book "Lorem Ipsum" has 1 copy left
    And I can borrow "Lorem Ipsum"

