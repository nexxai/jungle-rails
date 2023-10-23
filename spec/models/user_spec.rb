require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    context 'password' do 
      it 'returns an error when password is missing' do 
        @user = User.create({
          name: 'Bob Smith',
          email: 'bob@example.org',
          password_confirmation: 'supersecurepassword'
        })

        expect(@user.errors.full_messages).to include("Password can't be blank") 
      end

      it 'returns an error when password confirmation is missing' do
        @user = User.create({
          name: 'Bob Smith',
          email: 'bob@example.org',
          password: 'supersecurepassword'
        })

        expect(@user.errors.full_messages).to include("Password confirmation can't be blank") 
      end

      it 'returns an error when password and confirmation dont match' do
        @user = User.create({
          name: 'Bob Smith',
          email: 'bob@example.org',
          password: 'supersecurepassword',
          password_confirmation: 'this password doesnt match at all'
        })

        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'saves successfully if the password and confirmation match' do 
        @user = User.create({
          name: 'Bob Smith',
          email: 'bob@example.org',
          password: 'supersecurepassword',
          password_confirmation: 'supersecurepassword'
        })

        expect(@user.errors).to be_empty 
      end

      it 'returns an error if the password isnt long enough' do 
        @user = User.create({ 
          name: 'Bob Smith',
          email: 'bob@example.org',
          password: 'tooshort',
          password_confirmation: 'tooshort'
        })

        expect(@user.errors.full_messages).to include("Password is too short (minimum is 9 characters)")
      end
    end

    context 'email' do
      it 'returns an error when the email address already exists' do 
        @existinguser = User.create({
          name: 'Bob Smith',
          email: 'bob@example.org',
          password: 'supersecurepassword',
          password_confirmation: 'supersecurepassword'
        })

        @newuser = User.create({
          name: 'Bob Jones',
          email: 'bob@example.org',
          password: 'new password',
          password_confirmation: 'new password',
        })

        expect(@newuser.errors.full_messages).to include('Email has already been taken')
      end

      it 'returns an error when the email address already exists, even if in different case' do 
        @existinguser = User.create({
          name: 'Bob Smith',
          email: 'bob@example.org',
          password: 'supersecurepassword',
          password_confirmation: 'supersecurepassword'
        })

        @newuser = User.create({
          name: 'Bob Jones',
          email: 'BoB@eXaMpLe.OrG',
          password: 'new password',
          password_confirmation: 'new password',
        })

        expect(@newuser.errors.full_messages).to include('Email has already been taken')
      end
      
      it 'returns an error when the email is missing' do
        @user = User.create({
          name: 'Bob Smith',
          password: 'supersecurepassword',
          password_confirmation: 'supersecurepassword'
        })

        expect(@user.errors.full_messages).to include("Email can't be blank") 
      end
    end

    context 'name' do 
      it 'returns an error when the name is missing' do
        @user = User.create({
          email: 'bob@example.org',
          password: 'supersecurepassword',
          password_confirmation: 'supersecurepassword'
        })

        expect(@user.errors.full_messages).to include("Name can't be blank") 
      end
    end
  end

  describe '.authenticate_with_credentials' do 
    context 'Success' do 
      it 'returns a user object if the user successfully logs in' do 
        User.create({
          name: 'Bob Smith',
          email: 'bob@example.org',
          password: 'supersecurepassword',
          password_confirmation: 'supersecurepassword'
        })

        expect(User.authenticate_with_credentials('bob@example.org', 'supersecurepassword')).to be_a User
      end

      it 'should successfully login a user if they enter leading or trailing spaces in their email address' do 
        User.create({
          name: 'Bob Smith',
          email: 'bob@example.org',
          password: 'supersecurepassword',
          password_confirmation: 'supersecurepassword'
        })

        expect(User.authenticate_with_credentials('   bob@example.org    ', 'supersecurepassword')).to be_a User
      end

      it 'should successfully login a user if they enter their email in a case other than what was originally stored' do 
        User.create({
          name: 'Bob Smith',
          email: 'bob@example.org',
          password: 'supersecurepassword',
          password_confirmation: 'supersecurepassword'
        })

        expect(User.authenticate_with_credentials('BoB@eXamPlE.ORG', 'supersecurepassword')).to be_a User
      end
    end

    context 'Failure' do 
      it 'returns nothing if the user does not successfully log in' do 
        User.create({
          name: 'Bob Smith',
          email: 'bob@example.org',
          password: 'supersecurepassword',
          password_confirmation: 'supersecurepassword'
        })

        expect(User.authenticate_with_credentials('bob@example.org', 'obviouslywrongpassword')).to be_nil
      end
    end
  end
end
