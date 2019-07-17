Feature:
  As a Kabisaan
  I can log in
  so I can do authorized tasks

  Scenario: Show the sign up page
    Given I open the application
    When I click the "Sign in" button
    Then I see the sign in page
