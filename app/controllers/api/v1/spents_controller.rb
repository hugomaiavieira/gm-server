class Api::V1::SpentsController < ApplicationController
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

    spents = params[:spents].nil? ? [] : JSON.parse(params[:spents])

    spents.each do |spent|
      spent['user_id'] = user.id
      Spent.create_or_update(spent)
    end

    render status: 200, nothing: true
  end
end