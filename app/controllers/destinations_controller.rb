class DestinationsController < ApplicationController
  get '/destination/new' do
    if session[:user.id] != nil
      erb:'/destination/new'
    else
      redirect '/login'
    end
  end

  post '/destination/new' do
   redirect '/destination/new' if session[:user_id] != nil
   redirect '/login'
 end

 get '/destination' do
   if session[:user_id] != nil
     @user = current_user
     erb :'/destination/show' #test redirect change to a show page
   else
     redirect '/login'
   end
 end

 post '/destination' do
   @user = User.find(session[:user_id])
   redirect '/destination/new' if params[:destinations].empty?
   @user.destinations << Destination.new(params[:destinations])
   redirect "/user/#{@user.slug}"
 end

 get '/destination/:id' do
  if session[:user_id] != nil
    @destination = Destination.find(params[:id])
    #binding.pry
    erb :'/destination/show' #want to show destinations of user
  else
    redirect '/login'
  end
end

end
