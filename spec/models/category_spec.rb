require 'spec_helper'

describe Category do
  context 'should validate' do
    it 'the uniqueness of id' do
      user = FactoryGirl.create :user
      FactoryGirl.create :category, name: 'a', user_id: user.id, id: 'bla'
      category = FactoryGirl.build :category, name: 'b', user_id: user.id, id: 'bla'

      category.save.should be_false
      category.errors[:id].should include('has already been taken')
    end

    context 'the uniqueness of category name by user' do
      before(:all) do
        @user_a = FactoryGirl.create :user
        @user_b = FactoryGirl.create :user
        FactoryGirl.create :category, name: 'bla', user_id: @user_a.id
      end

      it 'equal name for same user' do
        category = FactoryGirl.build :category, name: 'bla', user_id: @user_a.id
        @user_a.reload

        category.save.should be_false
        category.errors[:name].should include('should be uniq')
      end

      it 'equal name for different user' do
        category = FactoryGirl.build :category, name: 'bla', user_id: @user_b.id
        @user_b.reload

        category.save.should be_true
      end
    end
  end

  context 'create or update' do
    before(:all) do
      Category.delete_all # TODO: remove it using database_cleaner
      @user = FactoryGirl.create :user
      @attributes = {
        id: 'abc123',
        name: 'fuel',
        user_id: @user.id
      }
    end

    it 'if category exist' do
      FactoryGirl.create :category, @attributes

      attr = @attributes.clone
      attr[:name] = 'gas'

      Category.create_or_update(attr)
      Category.all.should have(1).category
      Category.first.name.should == 'gas'
    end

    it 'if category not exist' do
      Category.create_or_update(@attributes)
      Category.all.should have(1).category
      Category.first.name.should == 'fuel'
    end
  end
end
