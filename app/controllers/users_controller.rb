class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'/user/new'
    else
      redirect '/signup'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:password].empty?
      redirect '/signup'
    else
      @user = User.create(:username => params[:username], :password => params[:password])
      session[:user_id] = @user.id
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
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/destination'
    else
      redirect '/login' #try again
    end
  end

  get '/logout' do
    if logged_in?
      #the user logs out
      session.clear
      redirect '/'
    end
  end

  get '/user/:slug' do
  @user = User.find_by_slug(params[:slug])
   erb :'user/show'
  end

end
