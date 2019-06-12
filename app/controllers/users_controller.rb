class UsersController < ApplicationController

  get '/signup' do
     # if logged_in?
     #   redirect to '/destination'
     # else
      erb :"user/new"
   # end
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

end
