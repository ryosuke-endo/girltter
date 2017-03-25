module LoginSpecHelper

  def login?
    session[:user_id].present?
  end

  def login_as(user)
    if integration_test?
      visit login_path
      fill_in 'email', with: user.email
      fill_in 'password', with: 'password'
      find('#login-btn').click
    elsif defined?(session)
      session[:user_id] = user.id
    else
      post user_sessions_path, params: { email: user.email,
                                         password: 'password' }
    end
  end

  def integration_test?
    defined?(visit)
  end
end
