Given(/^I am logged in as "(.*?)" with the password "(.*?)"$/) do |arg1, arg2|
  visit('/')
  email = 'email@example.com'
  password = 'test'
  fill_in "email", :with => email
  fill_in "password", :with => password
  click_button "Log in"
  text = 'Profile for'
  page.has_content? text
end

Given(/^I am in "(.*?)" Classroom$/) do |arg1|
  click_on('Virtual Communities')
  classroom_text = 'Welcome to Virtual Communities'
  page.has_content? classroom_text
end

Given(/^I create a blog entry with the title "(.*?)" and the body "(.*?)"$/) do |arg1, arg2|
    pending # express the regexp above with the code you wish you had
end

Then(/^I should see a blog entry with "(.*?)" in it$/) do |arg1|
    pending # express the regexp above with the code you wish you had
end

Then(/^I should see a headline with "(.*?)" in it$/) do |arg1|
    pending # express the regexp above with the code you wish you had
end

