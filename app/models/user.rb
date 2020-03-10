class User < ActiveRecord::Base
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :name, :email, :password, :password_confirmation, presence: true
  validates :password, length: { minimum: 6 }
  before_save { email.downcase! }

  has_secure_password


  def self.authenticate_with_credentials (email, password)
    user = User.find_by_email(email.downcase.strip)

    if user && user.authenticate(password)
      return user
    else
      return nil
    end

  end
  
end
