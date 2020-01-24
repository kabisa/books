Feature: Dashboard
  As a user
  I want quick access to interesting books

  Scenario: Enough books
    Given the following users:
      | email              |
      | marty@kabisa.nl    |
      | emmett@kabisa.nl   |
      | lorraine@kabisa.nl |
    And the following books:
      | title                  | link                                  | comments_count | created_at  |
      | Lorem Ipsum            | http://www.kabisa.nl/lorem-ipsum.epub | 5              | 10 days ago |
      | Dolor Sit              | http://kabisa.nl/dolor-sit.pdf        | 4              | 1 day ago   |
      | Morbi ullamcorper      | http://kabisa.nl/dolor-sit.pdf        |                | 3 days ago  |
      | Duis aute              | http://www.kabisa.nl/lorem-ipsum.epub | 2              | 4 days ago  |
      | fugiat nulla           | http://kabisa.nl/dolor-sit.pdf        | 3              | 5 days ago  |
      | Consectetur Adipiscing | http://kabisa.nl/consectetur/         | 1              | 6 days ago  |
      | sint occaecat          | http://kabisa.nl/morbi/               |                | 7 days ago  |
    And the following votes:
      | title                  | liked by                         | disliked by                                         |
      | Lorem Ipsum            | marty@kabisa.nl                  |                                                     |
      | Morbi ullamcorper      | marty@kabisa.nl emmett@kabisa.nl |                                                     |
      | Consectetur Adipiscing | lorraine@kabisa.nl               |                                                     |
      | sint occaecat          |                                  | marty@kabisa.nl emmett@kabisa.nl lorraine@kabisa.nl |
    When I open the application
    Then I see the book "Lorem Ipsum" suggested as "Latest comment"
    And I see the book "Dolor Sit" suggested as "Recently added"
    And I see the book "Morbi ullamcorper" suggested as "Most-liked book"

  Scenario: No books
    When I open the application
    Then I don't see any suggestions

  Scenario: 1 book
    Given the following books:
      | title                  | link                                  |
      | Lorem Ipsum            | http://www.kabisa.nl/lorem-ipsum.epub |
    When I open the application
    Then I don't see a book suggested as "Latest comment"
    And I see the book "Lorem Ipsum" suggested as "Recently added"
    And I see the book "Lorem Ipsum" suggested as "Most-liked book"

