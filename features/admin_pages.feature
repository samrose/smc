Feature: Create Roles
  Scenario: Default roles
    Given that I am logged in as the admin participant
    When I view admin role management page
    Then should see default roles of "student, teacher, admin"
  Scenario: Admin Role Creation
    Given that I am logged in as the admin participant
    Given that I am on the admin role mangement page
    When I type in "special role" in the submission form
    And I click "save"
    Then I should see "special role" in roles list
