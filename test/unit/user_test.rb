require 'test_helper'

class UserTest < Test::Unit::TestCase
  context User do
    setup do
      Coterie.connect # runs against the default local redis db
      Ohm.redis.flushdb
    end
    
    should "be creatable" do
      u = User.create(
        :name => "Bob", 
        :username => "bobbb",
        :email => "bob@example.com", 
        :password => "sekret")
    end
    
    should "have a valid password" do
      u = User.new(
        :name => "Jim",
        :username => "jimmm",
        :email => "jim@example.com")
      assert !u.valid?
      assert_contains u.errors, [:password, :not_present]
    end
    
    should "return friends as an intersection of followers and following" do
      u1 = User.create(:name => "Larry", :username => "barry", :email => "barry@example.com", :password => "bla")
      u2 = User.create(:name => "Larry", :username => "larry", :email => "larry@example.com", :password => "bla")
      u3 = User.create(:name => "Garry", :username => "garry", :email => "garry@example.com", :password => "bla")
      u = User.create(
        :name => "Bob", 
        :username => "bobbb",
        :email => "bob@example.com", 
        :password => "sekret")
      u.followers << u1
      u.followers << u2
      u.following << u2
      u.following << u3
      assert_does_not_contain u.friends, u1
      assert_contains u.friends, u2
      assert_does_not_contain u.friends, u3
    end
  end
end