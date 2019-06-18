class DestinationsController < ApplicationController
  get '/destination/new' do
    if session[:user_id] != nil
      erb:'/destination/new'
    else
      redirect '/login'
    end
  end

  post '/destination/new' do
    if session[:user_id] != nil
      redirect '/destination/new'
    else
    redirect '/login'
 end
end

 get '/destination' do
   # if session[:user_id] != nil
   #    @user = current_user
     # @destination = Destination.all
     erb :'/destination/show' #test redirect change to a show page
   # else
   #   redirect '/login'
   # end
 end

 post '/destination' do
   @user = User.find(session[:user_id])
   if params[:city].empty? #|| params[:country].empty? || params[:description].empty?
     redirect '/destination/new'
   else
   @user.destinations << Destination.new(params[:destinations])
   redirect "/user/#{@user.slug}"
 end
end

 get '/destination/:id' do
   if session[:user_id] != nil
    @destinations = Destination.find(params[:user_id])
    #binding.pry
    erb :'/destination/show' #want to show destinations of user
  else
    redirect '/login'
  end
end

  post '/destination/:id' do
    redirect "/destination/#{params[:user_id]}"
  end

  get '/destination/:id/edit' do
   if logged_in?
     @destinations = Destination.find(params[:user_id])
     if @destinations.user_id == current_user.user_id
       erb :'destination/edit'
     else
       redirect '/destination'
     end
   else
     redirect '/login'
   end
 end


  patch '/destination/:id' do
    @destinations = Destination.find(params[:user_id])
    @destinations.update(city: params[:city], country: params[:country], rating: params[:rating], description: params[:description])
    redirect "/destination/#{@destinations.user_id}"
  end
  end
