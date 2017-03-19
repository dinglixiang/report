class User < ApplicationRecord
  has_many :purchases
  has_many :reports
  has_many :stocks

  validates :username, presence: true

  def password
    @password
  end

  def password=(pass)
    return unless pass
    @password=pass
    generate_password(pass)
  end

  def self.authentication(username, password)
    @user = User.find_by_username(username)
    if @user && Digest::SHA256.hexdigest(password + @user.salt) == @user.password_digest
      return @user
    end
    false
  end

  private
  def generate_password(pass)
    self.salt = Array.new(10) { rand(1024).to_s(36) }.join
    self.password_digest = Digest::SHA256.hexdigest(pass + salt)
  end
end
