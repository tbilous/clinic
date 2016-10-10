def wait_until
  require 'timeout'
  Timeout.timeout(Capybara.default_wait_time) do
    sleep(1) until value == yield
    value
  end
end

def login(u)
  visit new_user_session_path
  fill_in 'user_email', with: u.email
  fill_in 'user_password', with: u.password
  click_button t(:sign_in)
end
