Given(/^that I am a user logging into the site$/) do
  visit('/logout')
end

When(/^I successfully authenticate$/) do
  visit('/')
  email = 'email@example.com'
  password = 'test'
  fill_in "email", :with => email
  fill_in "password", :with => password
  click_button "Log in"
end

Then(/^I should be redirected to my participant profile$/) do
   text = 'Profile for'
   page.has_content? text
end

Then(/^I should see my classrooms\.$/) do
    pending # express the regexp above with the code you wish you had
end

