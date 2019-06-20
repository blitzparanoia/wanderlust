class UsersController < ApplicationController

  get '/signup' do
    erb :"/user/new"
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
    erb :"/user/login"
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/user/#{@user.id}"
    else
      redirect '/login' #try again
    end
  end

  post '/user' do
  @user = User.new(params)
  if @user.save
    session[:user_id] = @user.id
    redirect to "/users/#{@user.id}" #account created
  else
    redirect to '/signup' # account not created
  end
end

# user route
get '/user/:id' do
    @user = User.find_by(id: params[:id])
    erb :'/user/show'
  end

  get '/logout' do
      # the user logs out
      session.clear
      redirect '/'
    end

end
