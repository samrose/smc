Given(/^I am not an authenticated participant$/) do
  visit('/logout')
end

When(/^I visit the home page$/) do
  visit('/')
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |arg1, arg2|
  email = 'email@example.com'
  password = 'test'
  fill_in "email", :with => email
  fill_in "password", :with => password
end

When(/^I press "(.*?)"$/) do |arg1|
  click_button "Log in"
end

Then(/^I should see "(.*?)"$/) do |arg1|
  text = 'Profile for'
  page.has_content? text
end

