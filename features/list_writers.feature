@javascript
Feature:
              As a user
              I want to see a list of authors and their books

        Scenario: Show writers
            Given there are 4 writers with books
              And there are 4 writers without books
             When I choose "Writers" from the navigation drawer
             Then I should see 4 cards with writers

        Scenario: Show writers
            Given the following books:
                  | title                  | link                                  | writer_names                  |
                  | Lorem Ipsum            | http://www.kabisa.nl/lorem-ipsum.epub | Stephen King, Charles Dickens |
                  | Dolor Sit              | http://kabisa.nl/dolor-sit.pdf        | Stephen Hawking, Stephen King |
                  | Consectetur Adipiscing | http://kabisa.nl/consectetur/         | Mark Twain, Stephen King      |
                  | Morbi ullamcorper      | http://kabisa.nl/morbi/               | Charles Dickens, Mark Twain   |
             When I choose "Writers" from the navigation drawer
             Then I expect to see "Consectetur Adipiscing +2"

        Scenario: Show all books for a specific writer
            Given the following books:
                  | title                  | link                                  | writer_names                  |
                  | Lorem Ipsum            | http://www.kabisa.nl/lorem-ipsum.epub | Stephen King, Charles Dickens |
                  | Dolor Sit              | http://kabisa.nl/dolor-sit.pdf        | Stephen Hawking, Stephen King |
                  | Consectetur Adipiscing | http://kabisa.nl/consectetur/         | Mark Twain, Stephen King      |
                  | Morbi ullamcorper      | http://kabisa.nl/morbi/               | Charles Dickens, Mark Twain   |
             When I choose "Writers" from the navigation drawer

             When I click on the card for writer "Stephen King"
             Then I should see a list of 3 books

        Scenario: Show more writers
            Given there are 72 writers with books
             When I choose "Writers" from the navigation drawer
             Then I should see 36 cards with writers
             When I scroll to the bottom of the page
             Then I should see 72 cards with writers
              And there are no more writers to be shown


