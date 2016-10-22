module LoginSpecHelper
  include Capybara::DSL

  def login?
    session[:user_id].present?
  end

  def login_as(user)
    visit login_path
    page.save_screenshot "capybara.png"
    fill_in 'email', with: user.email
    fill_in 'password', with: 'password'
    find('#login-btn').click
  end
end
