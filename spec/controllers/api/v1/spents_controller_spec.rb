require 'spec_helper'

describe Api::V1::SpentsController do
  context 'sync' do
    before(:all) do
      User.delete_all # TODO: use database cleaner to do this
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
      it 'without spents' do
        post 'sync', token: '123'
        response.status.should == 200
        response.body.should == ' '
      end

      it 'with spents' do
        post 'sync', token: '123', spents: '[{"id":"234iu","amount":"5.4","date":"2012-05-03"}]'
        response.status.should == 200
        response.body.should == ' '
        Spent.all.count == 1
        Spent.first.amount ==  5.4
      end
    end
  end
end