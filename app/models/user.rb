class User < ActiveRecord::Base
  has_many :posts
  
  attr_accessible :login, :password, :password_confirmation, :mail, :website, :status

  attr_accessor :password

  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :login
  validates_uniqueness_of :login
  validates_presence_of :password, :on => :create
  validates_presence_of :mail
  validates_uniqueness_of :mail
  validates_format_of :mail, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  
  
  def self.authenticate(login, password)
    user = find_by_login(login)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
    nil
    end
  end  
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
