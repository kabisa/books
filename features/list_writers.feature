Feature:
  As a user
  I want to see a list of authors and their books

        Background:
            Given the following books:
                  | title                  | link                                  | writer_names                  |
                  | Lorem Ipsum            | http://www.kabisa.nl/lorem-ipsum.epub | Stephen King, Charles Dickens |
                  | Dolor Sit              | http://kabisa.nl/dolor-sit.pdf        | Stephen Hawking, Stephen King |
                  | Consectetur Adipiscing | http://kabisa.nl/consectetur/         | Mark Twain, Stephen King      |
                  | Morbi ullamcorper      | http://kabisa.nl/morbi/               | Charles Dickens, Mark Twain   |
             When I choose "Writers" from the navigation drawer

        Scenario: Show writers
             Then I should see 4 cards with writers

        Scenario: Show writers
             Then I expect to see "Consectetur Adipiscing +2"
