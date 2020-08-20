@javascript
Feature: Show more
              As a user
              I want to see a limit number of books per page

        Scenario: See first 10 books
            Given there are 25 books
             When I choose "Books" from the navigation drawer
             Then I should see a list of 10 book

        Scenario: See all books
            Given there are 25 books
              And I choose "Books" from the navigation drawer
             Then I should see a list of 10 book
             When I scroll to the bottom of the page
             When I scroll to the bottom of the page
             Then I should see a list of 25 book
              And there are no more books to be shown
