class User < ActiveRecord::Base
  has_secure_password
  attr_accessible  :name, :password, :password_confirmation, :token
  before_create { generate_token(:token) }

  validates :name, :presence => true, :uniqueness => {:case_sensitive => false}
  validates :password, :length => { :minimum => 6 }, :on => :create
  has_many :comments
  has_many :posts
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
