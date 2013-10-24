# Load the Rails application.
require File.expand_path('../application', __FILE__)

#Needs to be filled out
ActionMailer::Base.smtp_settings = {
  :user_name => 'support@cremalab.com',
  :password => 'crema465132',
  :domain => 'http://cremalab-ideas.herokuapp.com',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}

# Initialize the Rails application.
SuiteApi::Application.initialize!
