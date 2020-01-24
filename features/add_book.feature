Feature:
  As a Kabisaan
  I can add a book
  So I can contribute to our books collection

  Background:
    Given the following locations:
      | city     |
      | Rome     |
      | Florence |
      | Sydney   |

  Scenario: Add first book
    Given I signed in as a Kabisaan
    When I click the "add" button
    Then I am adding a new book
    But I am not seeing the button for adding a new book

  Scenario: Guest cannot add a book
    Given I did not sign in
    When I navigate to page for adding a new book
    Then I see an error telling me I am not unauthorized
    And I'm back on the main page

