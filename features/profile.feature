Feature: Profile

  Scenario: Can edit profile
    Given I signed in as a Kabisaan
    When I choose "Profile" from the account menu
    Then I should be on my profile page

  @todo
  Scenario: Exiting profile
    Given I signed in as a Kabisaan
    And I am on my profile page
    When I exit my profile page
    Then I should be on the books page

  @todo
  Scenario: Edit a profile

  Scenario: Guest cannot access profile
