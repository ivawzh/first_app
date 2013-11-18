module SessionsHelper
  def sign_in(user)
    remember_token= User.new_remember_token  #generate a new token
    cookies.permanent[:remember_token]=remember_token #save the unencrypted token to browser cookies
    user.update_attribute(:remember_token, User.encrypt(remember_token)) #save the encrypted token to database
    self.current_user= user #tell application the user is signed in and who he is
  end

  def current_user=(user)
    @current_user= user
  end

  def current_user
    encrypted_token=User.encrypt(cookies[:remember_token])
    @current_user ||=User.find_by(remember_token:encrypted_token)
  end

  def sign_in?
    !current_user.nil?
  end

  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end

end
