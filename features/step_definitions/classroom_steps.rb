Given(/^I am logged in$/) do
  visit('/')
  email = 'email@example.com'
  password = 'test'
  fill_in "email", :with => email
  fill_in "password", :with => password
  click_button "Log in"
  text = 'Profile for'
  page.has_content? text
end

When(/^I click on a classroom$/) do
  click_on('Virtual Communities')
end

Then(/^I should be redirected to classroom dashboard$/) do
  classroom_text = 'Welcome to Virtual Communities'
  page.has_content? classroom_text
end

