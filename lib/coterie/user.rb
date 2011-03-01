class User < Ohm::Model
  include Ohm::Callbacks
  
  before :save, :encrypt_password
  
  attribute :name
  attribute :username
  attribute :email
  attribute :encrypted_password
  attr_accessor :password
  
  set :followers, User
  set :following, User
  
  index :username
  index :email
  index :encrypted_password
  
  def self.authenticate(username, password)
    
  end
  
  def friends
    followers.intersect(following)
  end
  
  def encrypt_password
    self.encrypted_password = encrypt(password)
  end
  
  def validate
    assert_present  :name
    assert_present  :username
    assert_present  :email
    assert_present  :password
    assert_unique   :username
    assert_unique   :email
  end
  
  private
  
  def salt
    Coterie::SALT
  end
  
  def encrypt(password)
    Digest::SHA1.hexdigest "--#{salt}--#{password}--"
  end
end