# frozen_string_literal: true

module LoginMacros
  def login_as(user)
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password',	with: 'password'
    click_button 'ログイン'
  end
end
