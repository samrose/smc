Feature: View my participant profile
  Scenario: Viewing profile
    Given that I am a user logging into the site
    When I successfully authenticate
    Then I should be redirected to my participant profile
    Then I should see my classrooms.
