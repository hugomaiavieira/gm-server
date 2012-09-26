require 'spec_helper'

describe Spent do
  context 'should validate' do
    context 'amount' do
      it { should have_valid(:amount).when(2.43, 5, 0.1) }
      it { should_not have_valid(:amount).when('', nil, 'abc', 0, -1) }
    end

    context 'date' do
      it { should have_valid(:date).when('2012-05-03') }
      it { should_not have_valid(:date).when('', nil) }
    end
  end

  context 'create or update' do
    before(:all) do
      # Spent.delete_all # TODO: remove it using database_cleaner
      @user = FactoryGirl.create :user
      @category = FactoryGirl.create :category, user_id: @user.id
      @attributes = {
        id: 'abc123',
        amount: 5.43,
        description: 'something',
        date: Date.today,
        category_id: @category.id,
        user_id: @user.id
      }
    end

    it 'if spent exist' do
      FactoryGirl.create :spent, @attributes

      attr = @attributes.clone
      attr[:amount] = 2.25

      Spent.create_or_update(attr)
      Spent.all.should have(1).spent
      Spent.first.amount.should == 2.25
    end

    it 'if spent not exist' do
      Spent.create_or_update(@attributes)
      Spent.all.should have(1).spent
      Spent.first.amount.should == 5.43
    end
  end
end
