@javascript
Feature:
  As a user
  I can retrieve a list of books
  so I can decide which one to read next

  Scenario: List books
    Given there are 5 e-books
    When I choose "Books" from the navigation drawer
    Then I should see a list of 5 books

  Scenario: List e-books and printed books
    Given there are 3 e-books
    And there are 5 printed books
    When I choose "Books" from the navigation drawer
    Then I should see a list of 3 e-books
    And I should see a list of 5 printed books

  Scenario: List e-books for guests
    Given there are 3 e-books
    And there are 5 printed books
    When I choose "Books" from the navigation drawer
    And I see 0 download links

  Scenario: List printed books for guests
    Given there are 5 printed books
    When I choose "Books" from the navigation drawer
    Then I should see a list of 5 printed books
    But I do not see information about how many copies there are

  Scenario: List e-books for authorized users
    Given I signed in as a Kabisaan
    And there are 3 e-books
    And there are 5 printed books
    When I choose "Books" from the navigation drawer
    Then I see 3 download links

  Scenario: List printed books authorized users
    Given I signed in as a Kabisaan
    And there are 5 printed books
    When I choose "Books" from the navigation drawer
    Then I should see a list of 5 printed books
    And I see information about how many copies there are

  Scenario: Expand panel for more details
    Given I signed in as a Kabisaan
    And the following e-books:
      | title       | link                                  | summary                      |
      | Lorem Ipsum | http://www.kabisa.nl/lorem-ipsum.epub | Lorem ipsum dolor sit amet.  |
      | Dolor Sit   | http://kabisa.nl/dolor-sit.pdf        | Consectetur adipiscing elit. |
    When I choose "Books" from the navigation drawer
    Then I do not see the summary for "Lorem Ipsum"
    When I expand the panel for "Lorem Ipsum"
    Then I see the summary for "Lorem Ipsum"

  @todo
  Scenario: Empty state

  Scenario: View vote info
    Given the following users:
      | email              |
      | marty@kabisa.nl    |
      | emmett@kabisa.nl   |
      | lorraine@kabisa.nl |
    And the following e-books:
      | title       | link                                  |
      | Lorem Ipsum | http://www.kabisa.nl/lorem-ipsum.epub |
    And the following votes:
      | title       | liked by                         | disliked by        |
      | Lorem Ipsum | marty@kabisa.nl emmett@kabisa.nl | lorraine@kabisa.nl |
    When I choose "Books" from the navigation drawer
    Then I see "2 likes" for the book "Lorem Ipsum"
    And I see "66%" for the book "Lorem Ipsum"
    But I do not see a like button for the book "Lorem Ipsum"
    And I do not see a dislike button for the book "Lorem Ipsum"

