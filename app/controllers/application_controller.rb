require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "SuperSecret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :index
  end

  helpers do
    def logged_in?
     true if !session[:user_id].nil?
   end

   def current_user
     User.find(session[:user_id])
   end
  end

end
