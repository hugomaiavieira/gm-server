class Api::V1::CategoriesController < ApplicationController
  def sync
    token = params[:token]

    unless token
      render status: 400, json: { message: 'You must provide an user token.' }
      return
    end

    user = User.find_by_authentication_token(params[:token])

    unless user
      render status: 401, json: { message: 'Invalid user token.' }
      return
    end

    categories = params[:categories].nil? ? [] : JSON.parse(params[:categories])

    categories.each do |category|
      category['user_id'] = user.id
      Category.create_or_update(category)
    end

    render status: 200, nothing: true
  end
end