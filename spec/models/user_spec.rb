require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'Validations' do
    subject {
      described_class.new(name: "Test User",
                          email: "jon@doe.com",
                          password: "password",
                          password_confirmation: "password")
    }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a password" do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a password confirmation" do
     subject.password_confirmation = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without matching password and password confirmation" do
      @user2 = User.new(name: "Test User",
                       email: "test@test.com",
                       password: "password",
                       password_confirmation: "wrongpassword")
      expect(@user2).to_not be_valid
    end

    it "is not valid without an email" do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it "is not valid when email already exists" do
      User.create!(name: "User 1",
                  email: "123@test.COM",
                  password: "password",
                  password_confirmation: "password")
      @user2 = User.new(name: "User 2",
                       email: "123@test.com",
                       password: "1234567",
                       password_confirmation: "1234567")
      expect(@user2).to_not be_valid
      expect(@user2.errors[:email]).to include("has already been taken")
    end

    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid if password is less than 6 characters" do
      @user = User.new(name: "User 2",
                      email: "TEST@test.com",
                      password: "123",
                      password_confirmation: "123")
      expect(@user).to_not be_valid    
      expect(@user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end

  end

  describe '.authenticate_with_credentials' do

    
    it "will not authenticate if the email and password do not match" do
      User.create!(name: "User 2",
                   email: "jane@test.com",
                   password: "1234567",
                   password_confirmation: "1234567")
      expect(User.authenticate_with_credentials("jane@test.com", "wrongpassword")).to be_nil
    end

    it "will authenticate if the email and password match" do
      expect(User.authenticate_with_credentials("bat@man.com", "1234567")).to match(User.find_by(email: "bat@man.com"))
    end

    it "will authenticate if the user enters additional spaces before of after the email address" do
      expect(User.authenticate_with_credentials("  bat@man.com ", "1234567")).to match(User.find_by(email: "bat@man.com"))
    end

    it "will authenitcate if the user types their email address in the wrong case" do
      expect(User.authenticate_with_credentials("bAT@man.COM", "1234567")).to match(User.find_by(email: "bat@man.com"))
    end
  end

end
