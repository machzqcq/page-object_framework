require 'watir-webdriver'
require 'selenium-webdriver'



Before do

  ENV['BROWSER'] = "chrome" if ENV['BROWSER'].nil?
  @browser = Watir::Browser.new ENV['BROWSER'].to_sym
  @browser.window.maximize
end


After do |scenario|
  if scenario.failed?
    Dir::mkdir('screenshots') if not File.directory?('screenshots')
    screenshot = "./screenshots/FAILED_#{scenario.name.gsub(' ','_').gsub(/[^0-9A-Za-z_]/, '')}.png"
    @browser.driver.save_screenshot(screenshot)
    embed screenshot, 'image/png'
  end
  @browser.cookies.clear
  @browser.quit

end



