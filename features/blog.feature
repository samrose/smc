Feature: Blog 
  
  Background: 
    Given I am logged in as "email@example.com" with the password "test" 
    Given I am in "Virtual Communities" Classroom 
  Scenario: As a user I can create a blog post 
    Given I create a blog entry with the title "<TitleText>" and the body "<BodyText>" 
    Then I should see a blog entry with "<BodyText>" in it 
    And I should see a headline with "<TitleText>" in it
