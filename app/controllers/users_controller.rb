class UsersController < ApplicationController

  get '/signup' do
    if !logged_in
      erb :'/user/new'
    else
      redirect '/destination'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:password].empty?
      redirect '/signup'
    else
      user = User.create(params)
      session[:user_id] = user.id
      redirect '/destination'
    end
  end

  get '/login' do
    if !logged_in?
     erb :'user/login'
   else
     redirect '/destination'
   end
  end

  post '/login' do
    # if params[:username].empty? || params[:password].empty?
    #   redirect '/login'
    # end

    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/destination'
    else
      redirect '/signup' #please log in message
    end
  end

  get '/logout' do
    if logged_in?
      #the user logs out
      session.destroy
      redirect '/'
    end
  end

  get '/user/:slug' do
  @user = User.find_by_slug(params[:slug])
  @destinations= @user.destinations
   erb :'user/show'
  end

end
