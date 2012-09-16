require 'spec_helper'

describe Api::V1::UsersController do
  context 'create' do
    it 'with invalid params' do
      post :create, user: { email: 'bla', password: '' }
      response.status.should == 400
      response.headers['Content-Type'].should == "application/json; charset=utf-8"
      response.body.should include('"email":["is invalid"]')
      response.body.should include('"password":["can\'t be blank"]')
    end

    it 'with valid params' do
      post :create, user: { email: 'user@mail.com', password: '123456', password_confirmation: '123456' }
      response.status.should == 200
      response.headers['Content-Type'].should == "application/json; charset=utf-8"
      response.body.should include('"token":"')
      response.body.should include('"success":true')
    end
  end

  context 'sign_in' do
    before(:all) do
      @user = FactoryGirl.create :user, authentication_token: 'blablabla'
    end

    context 'successfully with valid params' do
      it 'should reset and return the authentication token' do
        post :sign_in, user: { email: @user.email, password: @user.password }
        response.status.should == 200
        response.headers['Content-Type'].should == "application/json; charset=utf-8"
        response.body.should include('"token":"')
        response.body.should include('"success":true')
        @user.reload.authentication_token.should_not == 'blablabla'
      end
    end

    context 'unsuccessfully' do
      it 'without email' do
        post :sign_in, user: { email: '', password: @user.password }
        response.status.should == 400
        response.headers['Content-Type'].should == "application/json; charset=utf-8"
        response.body.should include('"message":"You must provide user email and password."')
      end

      it 'without password' do
        post :sign_in, user: { email: @user.email, password: '' }
        response.status.should == 400
        response.headers['Content-Type'].should == "application/json; charset=utf-8"
        response.body.should include('"message":"You must provide user email and password."')
      end

      it 'with unexistent email' do
        post :sign_in, user: { email: 'somecrazy@mail.com', password: @user.password }
        response.status.should == 401
        response.headers['Content-Type'].should == "application/json; charset=utf-8"
        response.body.should include('"message":"Invalid email or password."')
      end

      it 'with invalid password' do
        post :sign_in, user: { email: @user.email, password: 'wrong password' }
        response.status.should == 401
        response.headers['Content-Type'].should == "application/json; charset=utf-8"
        response.body.should include('"message":"Invalid email or password."')
      end
    end
  end
end