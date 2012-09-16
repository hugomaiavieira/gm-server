class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(params[:user])
    if user.save
      render status: 200, json: { token: user.authentication_token, success: true }
    else
      render status: 400, json: user.errors
    end
  end

  def sign_in
    email, password = params[:user][:email], params[:user][:password]

    if email.empty? or password.empty?
       render status: 400, json: { message: 'You must provide user email and password.' }
       return
    end

    user = User.find_by_email(email.downcase)

    if user.nil? or not user.valid_password?(password)
      render status: 401, json: { message: 'Invalid email or password.' }
    else
      user.reset_authentication_token! # devise method: http://migre.me/aDm83
      render status: 200, json: { token: user.authentication_token, success: true }
    end
  end
end