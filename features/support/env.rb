require 'selenium/webdriver'

username = 'YOUR_USERNAME'
authkey = 'YOUR_AUTHKEY'

# Defining capabilities of the test session, such as browser, OS, and resolution
caps = Selenium::WebDriver::Remote::Capabilities.new 
caps["name"] = "Cucumber Ruby" # A name for your test
caps["build"] = "1.0"  #Versioning data for your site or application as you test
caps["browserName"] = "Chrome" #You can get a full list of browser, OS, and resolution combinations from our API
caps["platform"] = "Windows 10" 
caps["screen_resolution"] = "1366x768" 
caps["record_video"] = "true"

driver = Selenium::WebDriver.for(:remote, :url => "http://#{username}:#{authkey}@hub.crossbrowsertesting.com:80/wd/hub", :desired_capabilities => caps)


Before do |scenario|
	@driver = driver
end
