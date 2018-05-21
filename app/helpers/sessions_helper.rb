module SessionsHelper

  def sign_in(user)
    remember_token = User.new_remember_token
  end
end
