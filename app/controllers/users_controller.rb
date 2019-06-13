class UsersController < ApplicationController

  get '/signup' do
     redirect '/destination' if session[:user_id] != nil
     erb :'/user/new'
end

  post '/signup' do

    redirect '/signup' if params[:username].empty? || params[:password].empty?
    @user = User.new(params)
      if @user.save
				session[:user_id] = @user.id
				redirect '/destination'
      else
        redirect '/signup'
  end
end

get '/login' do
  if session[:user_id] != nil
  @user = current_user
  redirect '/destination'
else
  erb :'user/login'
end
end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authernticate(params[:password])
      session[:user_id] = @user.id
      redirect '/destination'
    else
      redirect '/login'
  end
end

  get '/logout' do
    session.clear if session[:user_id] != nil
    redirect '/login'
  end

  # get '/users/:slug' do
  #     @user = User.find_by_slug(params[:slug])
  #     erb :'/users/show'
  # end



end
