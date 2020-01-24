@javascript
Feature: As a Kabisaan
  I can like or dislike a book
  So others can choose wisely

  Background:
    Given the following books:
      | title                       | link                                  | summary                      |
      | Lorem Ipsum                 | http://www.kabisa.nl/lorem-ipsum.epub | Lorem ipsum dolor sit amet.  |
    And I signed in as a Kabisaan

  Scenario: Like/dislike markup
    When I choose "Books" from the navigation drawer
    Then I see a like button for the book "Lorem Ipsum"
    And I see a dislike button for the book "Lorem Ipsum"

  Scenario: Like a book
    Given I choose "Books" from the navigation drawer
    When I like the book "Lorem Ipsum"
    Then I see 1 people like the book "Lorem Ipsum"
    And I see 0 people dislike the book "Lorem Ipsum"

  Scenario: Dislike a book
    Given I choose "Books" from the navigation drawer
    When I dislike the book "Lorem Ipsum"
    Then I see 0 people like the book "Lorem Ipsum"
    And I see 1 people dislike the book "Lorem Ipsum"

  Scenario: Unlike a book
    Given I liked the book "Lorem Ipsum"
    And I choose "Books" from the navigation drawer
    When I unlike the book "Lorem Ipsum"
    Then I see 0 people like the book "Lorem Ipsum"
    And I see 0 people dislike the book "Lorem Ipsum"

  Scenario: Undislike a book
    Given I disliked the book "Lorem Ipsum"
    And I choose "Books" from the navigation drawer
    When I undislike the book "Lorem Ipsum"
    Then I see 0 people like the book "Lorem Ipsum"
    And I see 0 people dislike the book "Lorem Ipsum"

  Scenario: Dislike a book I liked before
    Given I choose "Books" from the navigation drawer
    When I like the book "Lorem Ipsum"
    And I dislike the book "Lorem Ipsum"
    Then I see 0 people like the book "Lorem Ipsum"
    And I see 1 people dislike the book "Lorem Ipsum"
