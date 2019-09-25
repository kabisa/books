@javascript
Feature: As a Kabisaan
  I can like or dislike a book
  So others can choose wisely

  Scenario: Like/dislike markup
    Given I signed in as a Kabisaan
    And the following e-books:
      | title                       | link                                  | summary                      |
      | Lorem Ipsum                 | http://www.kabisa.nl/lorem-ipsum.epub | Lorem ipsum dolor sit amet.  |
    When I choose "Books" from the navigation drawer
    Then I see a like button for the book "Lorem Ipsum"
    And I see a dislike button for the book "Lorem Ipsum"

  Scenario: Like a book
    Given I signed in as a Kabisaan
    And the following e-books:
      | title                       | link                                  | summary                      |
      | Lorem Ipsum                 | http://www.kabisa.nl/lorem-ipsum.epub | Lorem ipsum dolor sit amet.  |
    And I choose "Books" from the navigation drawer
    When I like the book "Lorem Ipsum"
    Then I see 1 people like the book "Lorem Ipsum"
    And I see 0 people dislike the book "Lorem Ipsum"

  Scenario: Dislike a book
    Given I signed in as a Kabisaan
    And the following e-books:
      | title                       | link                                  | summary                      |
      | Lorem Ipsum                 | http://www.kabisa.nl/lorem-ipsum.epub | Lorem ipsum dolor sit amet.  |
    And I choose "Books" from the navigation drawer
    When I dislike the book "Lorem Ipsum"
    Then I see 0 people like the book "Lorem Ipsum"
    And I see 1 people dislike the book "Lorem Ipsum"

  Scenario: Unlike a book
    Given I signed in as a Kabisaan
    And the following e-books:
      | title                       | link                                  | summary                      |
      | Lorem Ipsum                 | http://www.kabisa.nl/lorem-ipsum.epub | Lorem ipsum dolor sit amet.  |
    And I liked the book "Lorem Ipsum"
    And I choose "Books" from the navigation drawer
    When I unlike the book "Lorem Ipsum"
    Then I see 0 people like the book "Lorem Ipsum"
    And I see 0 people dislike the book "Lorem Ipsum"

  @wip
  Scenario: Undislike a book
    Given I signed in as a Kabisaan
    And the following e-books:
      | title                       | link                                  | summary                      |
      | Lorem Ipsum                 | http://www.kabisa.nl/lorem-ipsum.epub | Lorem ipsum dolor sit amet.  |
    And I disliked the book "Lorem Ipsum"
    And I choose "Books" from the navigation drawer
    When I undislike the book "Lorem Ipsum"
    Then I see 0 people like the book "Lorem Ipsum"
    And I see 0 people dislike the book "Lorem Ipsum"

  Scenario: Dislike a book I liked before

  Scenario: See number of likes and dislikes for a book
