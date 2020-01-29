@javascript
Feature:
  As a user
  I want to see details of a specific book

  Background:
    Given the following books:
      | title       | link                                  |
      | Lorem Ipsum | http://www.kabisa.nl/lorem-ipsum.epub |
      | Dolor Sit   |                                       |
    And the following locations:
      | city     |
      | Rome     |
    And the book "Dolor Sit" is available at the following locations:
      | location | copies |
      | Rome     | 1      |

  Scenario: Don't see the 'View Details' link
    When I choose "Books" from the navigation drawer
    Then I cannot view the details for "Lorem Ipsum"

  Scenario: See the 'View Details' link
    Given I choose "Books" from the navigation drawer
    When I expand the panel for "Lorem Ipsum"
    Then I can view the details for "Lorem Ipsum"

  Scenario: View details for an ebook
    Given I choose "Books" from the navigation drawer
    When I expand the panel for "Lorem Ipsum"
    And I click "View Details"
    Then I am viewing the book "Lorem Ipsum"
    But I should not see a download link

  Scenario: View details for a printed book
    Given I choose "Books" from the navigation drawer
    When I expand the panel for "Dolor Sit"
    And I click "View Details"
    Then I am viewing the book "Dolor Sit"
    But I should not see a download link

  Scenario: View details for an ebook
    Given I signed in as a Kabisaan
    And I choose "Books" from the navigation drawer
    When I expand the panel for "Lorem Ipsum"
    And I click "View Details"
    Then I am viewing the book "Lorem Ipsum"
    And I should see a download link

  Scenario: View details for a printed book
    Given I signed in as a Kabisaan
    And I choose "Books" from the navigation drawer
    When I expand the panel for "Dolor Sit"
    And I click "View Details"
    Then I am viewing the book "Dolor Sit"
    And I should see a borrow button
    But I should not see a download link
