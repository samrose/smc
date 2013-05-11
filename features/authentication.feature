Feature: Participant authentication functions
  Scenario: logging in
  Given I am not an authenticated participant
  When I visit the home page
  And I fill in "email" with "<email>"
  And I fill in "password" with "<password>"
  And I press "Log In"
  Then I should see "Profile for"
