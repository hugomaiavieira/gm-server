require 'spec_helper'

describe Api::V1::CategoriesController do
  context 'sync' do
    before(:all) do
      @user = FactoryGirl.create :user, authentication_token: '123'
    end

    it 'without token' do
      post 'sync'
      response.status.should == 400
      response.body.should include('"message":"You must provide an user token."')
    end

    it 'with invalid token' do
      post 'sync', token: 'abc'
      response.status.should == 401
      response.body.should include('"message":"Invalid user token."')
    end

    context 'with valid token' do
      it 'without categories' do
        post 'sync', token: '123'
        response.status.should == 200
        response.body.should == ' '
      end

      it 'with categories' do
        post 'sync', token: '123', categories: '[{"id":"234iu","name":"gas"}]'
        response.status.should == 200
        response.body.should == ' '
        Category.all.count == 1
        Category.first.name ==  'gas'
      end
    end
  end
end