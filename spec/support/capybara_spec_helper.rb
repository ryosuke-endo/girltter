require 'selenium-webdriver'
module CapybaraSpecHelper
  # Capybara Configuration
  Capybara.register_driver :chrome do |app|
    Capybara::Selenium::Driver.new(app, :browser => :chrome)
  end
  if ENV['CHROME_DRIVER'].present?
    Capybara.javascript_driver = :chrome
  else
    Capybara.javascript_driver = :webkit
  end

end
