<h1><strong>Getting Started with Cucumber Ruby and CrossBrowserTesting</strong></h1>
<p><em>For this document, we provide an example test located in our&nbsp;<a href="https://github.com/crossbrowsertesting/selenium-cucumber-ruby">Cucumber Ruby Github Repository</a>.</em></p>
<p>Want a powerful and easy to use command line tool for running Selenium tests?&nbsp;<a href="https://cucumber.io/">Cucumber</a>&nbsp;might be the option for you. Cucumber provides language-bindings for the powerful browser-driving tool&nbsp;<a href="http://www.seleniumhq.org/docs/" rel="nofollow">Selenium</a>. Its&nbsp;<a href="https://docs.cucumber.io/gherkin/" rel="nofollow">Gherkin</a> language allows you to write your tests in a way that can be easily read by anyone on your team. Cucumber Ruby integrates easily with the CrossBrowserTesting platform, so you can perform tests on a wide variety of OS/Device/Browser combinations, all from one test.</p>
<h3>Let’s walk through getting setup.</h3>
<p>First we need to create a new folder, get Cucumber and Selenium installed, and initialize your project. You can do this using Gem:</p>
<p><code class=" prettyprinted"><span class="pln">gem install cucumber</span></code><br>
<code class=" prettyprinted"><span class="pln">gem install selenium-webdriver&nbsp;</span></code><br>
<code class=" prettyprinted"><span class="pln">gem install test-unit</span></code><code class=" prettyprinted"></code></p>
<p>Initialize your Cucumber project using the command:</p>
<pre><code>cucumber --init</code></pre>
<p>We’ll first need to create a feature file where our test steps are defined in the Gherkin language. Save the following as features/todo.feature:</p>
<pre><code>Feature: ToDo App
  Scenario: Archiving ToDos
    Given I go to my ToDo App
    When I archive all todos
    Then I should have no todos
 </code></pre>
<p>Next we need to define the procedural code. This will be the Ruby that works with the Selenium language bindings to create the logic of our test. Save the following as features/step_definitions/stepdefs.rb:</p>
<pre><code>require 'test/unit/assertions'
include Test::Unit::Assertions

Given("I go to my ToDo App") do
	@driver.navigate.to("http://crossbrowsertesting.github.io/todo-app.html")
end

When("I archive all todos") do
	@driver.find_element(:name, "todo-1").click()
	@driver.find_element(:name, "todo-2").click()
	@driver.find_element(:name, "todo-3").click()
	@driver.find_element(:name, "todo-4").click()
	@driver.find_element(:name, "todo-5").click()
	@driver.find_element(:link_text, "archive").click()
end

Then("I should have no todos") do
	elems = @driver.find_elements(:class, "done-true")
	assert_equal(0, elems.length)
end

After do
	if @driver!= nil
		@driver.quit
	end
end </code></pre>
<p>Last, we’ll need to create a new file features/step_definitions/env.rb that defines our connection to the remote hub:</p>
<div class="blue-alert">You’ll need to use your Username and Authkey to run your tests on CrossBrowserTesting. To get yours, sign up for a&nbsp;<a href="https://crossbrowsertesting.com/freetrial"><b>free trial</b></a>&nbsp;or purchase a&nbsp;<a href="https://crossbrowsertesting.com/pricing"><b>plan</b></a>.</div>
<pre><code>require 'selenium/webdriver'

username = 'YOUR_USERNAME'
authkey = 'YOUR_AUTHKEY'

caps = Selenium::WebDriver::Remote::Capabilities.new 
caps["name"] = "Cucumber Ruby" # A name for your test
caps["build"] = "1.0"  #Versioning data for your site or application as you test
caps["browserName"] = "Chrome" #You can get a full list of browser, OS, and resolution combinations from our API
caps["platform"] = "Windows 10" 
caps["screen_resolution"] = "1366x768" 
caps["record_video"] = "true"

driver = Selenium::WebDriver.for(:remote, :url =&gt; "http://#{username}:#{authkey}@hub.crossbrowsertesting.com:80/wd/hub", :desired_capabilities =&gt; caps)


Before do |scenario|
	@driver = driver
end
 </code></pre>
<p>Congratulations! You have successfully integrated CBT and Cucumber for Ruby. Now you are ready to run your test using the command:</p>
<pre><code>cucumber</code></pre>
<p>As you can probably make out from our test, we visit a small ToDo App example, interact with our page, and use assertions to verify that the changes we’ve made are actually reflected in our app.</p>
<p>We kept it short and sweet for our purposes, but there is so much more you can do with Cucumber Ruby! Being built on top of Selenium means the sky is the limit as far as what you can do. If you have any questions or concerns, feel <a href="mailto:info@crossbrowsertesting.com">free to get in touch</a>.</p>
