class UsersController < ApplicationController

  get '/signup' do
     redirect '/destination' if session[:user_id] != nil
     erb :'/user/new'
end

  post '/signup' do
    if params[:username].empty? || params[:password].empty?
      @user = User.create(params)
      if @user.save
        session[:user_id] = @user.id
        redirect '/destination'
      else
        redirect '/signup'
  end
end
end

  get '/login' do
  end





end
