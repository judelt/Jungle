require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it "should create a valid user" do
      @user = User.new(
        first_name: 'Judit',
        last_name: 'Mendez',
        email: 'judit@mendez.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(@user).to be_valid
    end

    it "should validate that first_name is present before saving" do
      @user = User.new(
        first_name: nil,
        last_name: 'Mendez',
        email: 'judit@mendez.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(@user).to_not be_valid
      expect(@user.errors[:first_name]).to include("can't be blank")
    end

    it "should validate that last_name is present before saving" do
      @user = User.new(
        first_name: 'Judit',
        last_name: nil,
        email: 'judit@mendez.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(@user).to_not be_valid
      expect(@user.errors[:last_name]).to include("can't be blank")
    end

    it "should validate that email is present before saving" do
      @user = User.new(
        first_name: 'Judit',
        last_name: 'Mendez',
        email: nil,
        password: 'password',
        password_confirmation: 'password'
      )
      expect(@user).to_not be_valid
      expect(@user.errors[:email]).to include("can't be blank")
    end


    it "should validate that emails are unique" do
      @user1 = User.create(
        first_name: 'Judit',
        last_name: 'Mendez',
        email: 'judit@mendez.com',
        password: 'password',
        password_confirmation: 'password'
      )
      
      @user2 = User.new(
        first_name: 'Michael',
        last_name: 'M.',
        email: 'JUDIT@mendeZ.com',
        password: 'passpass',
        password_confirmation: 'passpass'
      )

      expect(@user2).to_not be_valid
      expect(@user2.errors[:email]).to include("has already been taken")
      
    end

    it "should validate that password is present before saving" do
      @user = User.new(
        first_name: 'Judit',
        last_name: 'Mendez',
        email: 'judit@mendez.com',
        password: nil,
        password_confirmation: 'password'
      )
      expect(@user).to_not be_valid
      expect(@user.errors[:password]).to include("can't be blank")
    end

    it "should validate that password_confirmation is present before saving" do
      @user = User.new(
        first_name: 'Judit',
        last_name: 'Mendez',
        email: 'judit@mendez.com',
        password: 'password',
        password_confirmation: nil
      )
      expect(@user).to_not be_valid
      expect(@user.errors[:password_confirmation]).to include("can't be blank")
    end

    it "should validate that the passwords match before saving" do
      @user = User.new(
        first_name: 'Judit',
        last_name: 'Mendez',
        email: 'judit@mendez.com',
        password: 'password',
        password_confirmation: 'pasword'
      )
      expect(@user).to_not be_valid
      expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it "should validate that passwords have a minimum length of 6 characters" do
      @user = User.new(
        first_name: 'Judit',
        last_name: 'Mendez',
        email: 'judit@mendez.com',
        password: 'pass',
        password_confirmation: 'pass'
      )
      expect(@user).to_not be_valid
      expect(@user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end

  end

  describe '.authenticate_with_credentials' do

    it 'should authenticate a user' do
      @user = User.create(
        first_name: 'Judit',
        last_name: 'Mendez',
        email: 'judit@mendez.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(@user.errors).to be_empty
      expect(User.authenticate_with_credentials('judit@mendez.com', 'password')).to eq(@user)
    end 

    it 'should return nil for an invalid user' do
      @user = User.create(
        first_name: 'Judit',
        last_name: 'Mendez',
        email: 'judit@mendez.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(@user.errors).to be_empty
      expect(User.authenticate_with_credentials('judit@mendez.com', 'passwword')).to be(nil)
    end

    it 'should authenticate a user with extra spaces in the email' do
      @user = User.create(
        first_name: 'Judit',
        last_name: 'Mendez',
        email: 'judit@mendez.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(@user.errors).to be_empty
      expect(User.authenticate_with_credentials('  judit@mendez.com  ', @user.password)).to eq(@user)
    end 

    it 'should authenticate a user with the wrong case for the email' do
      @user = User.create(
        first_name: 'Judit',
        last_name: 'Mendez',
        email: 'judit@mendez.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(@user.errors).to be_empty
      expect(User.authenticate_with_credentials('juDit@Mendez.com', 'password')).to eq(@user)
    end 

  end

end