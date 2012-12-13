require 'spec_helper'

describe User do

  describe ".create_with_omniauth" do

    let (:auth) do
      OmniAuth::AuthHash.new({  :provider => 'github',
                                :uid => '12345',
                                :info => {  :email => "foo@bar.com",
                                            :image => "http://someimage.com/url",
                                            :nickname => "foobar",
                                            :name => "John Doe" }
                            })
    end

    let (:user) { User.find_by_uid("12345") }

    it "should save a user from the OmniAuth hash with the correct name" do  
      User.create_with_omniauth(auth)
      user.name.should == "John Doe"
    end

    it "should save a user from the OmniAuth hash with the correct email" do
      User.create_with_omniauth(auth)
      user.email.should == "foo@bar.com"
    end

    it "should save a user from the OmniAuth hash with the correct image url" do
      User.create_with_omniauth(auth)
      user.image.should == "http://someimage.com/url"
    end

    it "should save a user from the OmniAuth hash with the correct nickname" do
      User.create_with_omniauth(auth)
      user.nickname.should == "foobar"
    end

  end

  describe ".is_the_owner_registered?" do

    it "should return true if github username matches a user in the db" do
      User.create(:nickname => "foobar")
      User.is_the_owner_registered?("foobar").should be_true
    end

    it "should return false if github username does not match a user in the db" do
      User.new(:nickname => "foobar")
      User.is_the_owner_registered?("foobar").should be_false
    end

  end


end
