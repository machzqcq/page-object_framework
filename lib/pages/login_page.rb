class LoginPage < GenericBasePage
  include DataHelper

  element(:email) {|b| b.text_field(id: "email")}
  element(:password) {|b| b.text_field(id: "passwd")}
  element(:signin_button) {|b| b.button(id: "SubmitLogin")}


  def login(username="abc@xyz.com",passwd="Test@123")
    email.set username
    password.set passwd
    signin_button.click
  end

  def login_yml(options={})
    options.to_hash.merge!(default_data_directory:"lib/config/data")
    set_data_directory options['default_data_directory']
    email.set data_yml_hash['username']
    password.set data_yml_hash['password']
    signin_button.click
  end


end
