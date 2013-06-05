Feature: Classroom Dashboard
  Scenario: Viewing Classroom
    Given I am logged in
    When I click on a classroom
    Then I should be redirected to classroom dashboard
