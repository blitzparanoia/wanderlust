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
     erb :'/destination/edit'
   else
     redirect '/login'
 end

 post '/destination' do
   @user = User.find(session[:user_id])
   redirect 'destination/new' if  params[:destination][:city].empty?
   @user.destinations << Destination.new(params[:destination])
   redirect "/user/#{@user.slug}"
 end

end
end
