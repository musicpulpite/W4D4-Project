# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#

class User < ApplicationRecord

  # extend ActiveModel::Naming

  validates :email, :password_digest, :session_token, presence: true
  validates :email, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :ensure_session_token

  attr_reader :password
  # attr_reader :errors


  # def initialize
  #   @errors = ActiveModel::Errors.new(self)
  # end


  def self.find_by_credentials(email, password)
    @user = User.find_by(email: email)

    return @user if @user.is_password?(password)
    return nil
  end


  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(@password)
  end

  def is_password?(password)
    password_digest_obj = BCrypt::Password.new(self.password_digest)
    password_digest_obj.is_password?(password)
  end

  private

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end
end
