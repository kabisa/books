@javascript
Feature:
  As a user
  I want to see details of a specific book

  Background:
    Given the following books:
      | title                  | link                                  |
      | Lorem Ipsum            | http://www.kabisa.nl/lorem-ipsum.epub |

  Scenario: Don't see the 'View Details' link
    When I choose "Books" from the navigation drawer
    Then I cannot view the details for "Lorem Ipsum"

  Scenario: See the 'View Details' link
    Given I choose "Books" from the navigation drawer
    When I expand the panel for "Lorem Ipsum"
    Then I can view the details for "Lorem Ipsum"

  Scenario: View details
    Given I choose "Books" from the navigation drawer
    When I expand the panel for "Lorem Ipsum"
    And I click "View Details"
    Then I am viewing the book
