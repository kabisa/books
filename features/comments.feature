@javascript
Feature:
  As a Kabisaan
  I can add a comment to a specific book

  Scenario: View comments for a specific book
    Given the following books:
      | title       | link                                  | comments_count |
      | Lorem Ipsum | http://www.kabisa.nl/lorem-ipsum.epub | 3              |
      | Dolor Sit   | http://kabisa.nl/dolor-sit.pdf        | 5              |
    When I am viewing the details for "Lorem Ipsum"
    Then I see 3 comments

  Scenario: Add comment
    Given the following books:
      | title                  | link                                  |
      | Lorem Ipsum            | http://www.kabisa.nl/lorem-ipsum.epub |
    And I signed in with my email address "john.doe@kabisa.nl"
    And I am viewing the details for "Lorem Ipsum"
    When I comment with "This is an awesome book"
    Then I should see 1 comment by me
    When I sign out
    And I am viewing the details for "Lorem Ipsum"
    Then I should see 1 comment by "john.doe@kabisa.nl"

  Scenario: Add comment anonymously
    Given the following books:
      | title                  | link                                  |
      | Lorem Ipsum            | http://www.kabisa.nl/lorem-ipsum.epub |
    And I signed in as a Kabisaan
    And I would like to comment anonymously
    And I am viewing the details for "Lorem Ipsum"
    And I comment with "This is an awesome book"
    Then I should see 1 comment by me
    When I sign out
    And I am viewing the details for "Lorem Ipsum"
    Then I should see 1 anonymous comment

  Scenario: Create invalid comment
    Given the following books:
      | title                  | link                                  |
      | Lorem Ipsum            | http://www.kabisa.nl/lorem-ipsum.epub |
    And I signed in as a Kabisaan
    And I am viewing the details for "Lorem Ipsum"
    When I comment with ""
    Then I see a validation error "Comment can't be blank"
    And I see 0 comments

  Scenario: Guest cannot add comments
    Given the following books:
      | title                  | link                                  |
      | Lorem Ipsum            | http://www.kabisa.nl/lorem-ipsum.epub |
    When I am viewing the details for "Lorem Ipsum"
    Then I cannot add a comment

  Scenario: Remove my comment
    Given the following books:
      | title                  | link                                  |
      | Lorem Ipsum            | http://www.kabisa.nl/lorem-ipsum.epub |
    And I signed in as a Kabisaan
    And I am viewing the details for "Lorem Ipsum"
    And I comment with "This is an awesome book"
    When I delete the comment "This is an awesome book"
    Then I see 0 comments

  Scenario: See number of comments
    Given the following books:
      | title       | link                                  | comments_count |
      | Lorem Ipsum | http://www.kabisa.nl/lorem-ipsum.epub | 3              |
      | Dolor Sit   | http://kabisa.nl/dolor-sit.pdf        | 5              |
    When I choose "Books" from the navigation drawer
    Then I see 3 comments for the book "Lorem Ipsum"

  Scenario: Undo a deletion
    Given the following books:
      | title                  | link                                  |
      | Lorem Ipsum            | http://www.kabisa.nl/lorem-ipsum.epub |
    And I signed in as a Kabisaan
    And I am viewing the details for "Lorem Ipsum"
    And I comment with "This is an awesome book"
    When I delete the comment "This is an awesome book"
    And I undo deleting the comment
    Then I see 1 comment
