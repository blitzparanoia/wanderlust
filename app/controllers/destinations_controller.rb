class DestinationsController < ApplicationController

  get '/destination' do
    if logged_in?
      @destinations = Destination.all
      @user= current_user
      erb :'/destination/show'
    else
      redirect to '/login'
    end
  end



  get '/destination/new' do
    @destinations = Destination.all
    if logged_in?
      erb :'destination/new'
    else
      redirect '/login'
  end
end

#   post '/destination/new' do
#  #    if session[:user_id] != nil
#  #      redirect '/destination/new'
#  #    else
#  #    redirect '/login'
#  # end
#
# end

 post '/destination' do
   if params[:city].empty? || params[:country].empty? || params[:description].empty?
     redirect '/destination/new'
   else
     destination = Destination.create(params)
     current_user.destinations << destination
     redirect '/destination/#{destination.id}'
   end
 end

#  if logged_in?
#     if Destination.new(params[:destinations]).valid?
#       @destination = current_user.destinations.build(params[:destinations])
#       @destination.save
#       redirect to "/destination"
#     else
#       redirect to "/destination/new"
#     end
#   end
# end

 get '/destination/:id' do
   if !logged_in?
     redirect '/login'
   end
    @destination = Destination.find(params[:id])
    #binding.pry
    erb :'/destination/show' #want to show destinations of user
  end

get '/destination/:slug' do
   @destination = Destination.find_by_slug(params[:slug])
   erb :'destination/show'
 end

  # post '/destination/:slug' do
  #   redirect "/destination/#{params[:user_id]}"
  # end

  get '/destination/:id/edit' do
   if !logged_in?
     redirect '/login'
   end
     @destination = Destination.find(params[:id])
     if current_user.id != @destination.user_id
       redirect '/destination'
     end
     erb :'/destination/edit'
 end


  patch '/destination/:id' do
    if params[:city].empty? || params[:country].empty? || params[:description].empty?
     redirect "description/#{params[:id]}/edit"
   end
   @destination=Destination.find(params[:id])
   @destination.city=params[:city]
   @destiantion.country=params[:country]
   @destination.rating=params[:rating]
   @destination.description=params[:description]
   @destination.save
   redirect "/destination/#{@destination.id}"
  end

    delete '/destination/:id/delete' do
      if logged_in?
    @destination=Destination.find(params[:id])

  if current_user == @destination.user_id
    @destination.delete
  end
    redirect "/destination"
  else
    redirect "/login"
  end
  end
end
