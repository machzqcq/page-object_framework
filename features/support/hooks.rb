include SauceLabs
Before do
  ENV['BROWSER'] = "chrome" if ENV['BROWSER'].nil?
  ENV['WHERE'] = "local" if ENV['WHERE'].nil?
  if(ENV['WHERE']=="remote")
    @browser = SauceLabs.watir_browser(ENV['BROWSER'].to_sym,{url:"http://localhost:4444/wd/hub"})
  else
    # @browser = SauceLabs.watir_browser(ENV['BROWSER'].to_sym)
    @browser = Watir::Browser.new ENV['BROWSER'].to_sym
  end
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

at_exit do
  ENV['ARCHIVE_RESULTS'] = 'no' if ENV['ARCHIVE_RESULTS'].nil?
  if ENV['ARCHIVE_RESULTS']=="yes"
    Dir.mkdir("resultsarchive") if Dir["resultsarchive"].empty?
    folder = Dir.pwd
    input_filenames = ['results.html']

    zipfile_name = "#{Date.today}_results.zip"

    Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
      input_filenames.each do |filename|
        zipfile.add(filename, folder + '/' + filename)
      end
    end
    FileUtils.mv(zipfile_name,"resultsarchive/#{zipfile_name}")
  end
end



