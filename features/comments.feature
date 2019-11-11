@javascript
Feature:
  As a Kabisaan
  I can add a comment to a specific book

  Scenario: View comments for a specific book
    Given the following e-books:
      | title                  | link                                  | comments_count |
      | Lorem Ipsum            | http://www.kabisa.nl/lorem-ipsum.epub | 3 |
      | Dolor Sit              | http://kabisa.nl/dolor-sit.pdf        | 5 |
    When I am viewing the details for "Lorem Ipsum"
    Then I see 3 comments

  Scenario: Add comment
    Given the following e-books:
      | title                  | link                                  |
      | Lorem Ipsum            | http://www.kabisa.nl/lorem-ipsum.epub |
    And I signed in as a Kabisaan
    And I am viewing the details for "Lorem Ipsum"
    When I comment with "This is an awesome book"
    Then I see 1 comment

  Scenario: Create invalid comment
    Given the following e-books:
      | title                  | link                                  |
      | Lorem Ipsum            | http://www.kabisa.nl/lorem-ipsum.epub |
    And I signed in as a Kabisaan
    And I am viewing the details for "Lorem Ipsum"
    When I comment with ""
    Then I see a validation error "Comment can't be blank"
    And I see 0 comments

  Scenario: Guest cannot add comments
    Given the following e-books:
      | title                  | link                                  |
      | Lorem Ipsum            | http://www.kabisa.nl/lorem-ipsum.epub |
    When I am viewing the details for "Lorem Ipsum"
    Then I cannot add a comment

  Scenario: Remove my comment
    Given the following e-books:
      | title                  | link                                  |
      | Lorem Ipsum            | http://www.kabisa.nl/lorem-ipsum.epub |
    And I signed in as a Kabisaan
    And I am viewing the details for "Lorem Ipsum"
    And I comment with "This is an awesome book"
    When I delete the comment "This is an awesome book"
    Then I see 0 comments

  @wip
  Scenario: See number of comments
    Given the following e-books:
      | title                  | link                                  | comments_count |
      | Lorem Ipsum            | http://www.kabisa.nl/lorem-ipsum.epub | 3 |
      | Dolor Sit              | http://kabisa.nl/dolor-sit.pdf        | 5 |
    When I choose "Books" from the navigation drawer
    Then I see "3 Comments" for the book "Lorem Ipsum"
