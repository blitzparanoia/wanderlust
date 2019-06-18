class DestinationsController < ApplicationController
  get '/destination' do

    @destinations = Destination.all
      erb :'/destination/show'
  end

  get '/destination/new' do
    # if session[:user_id] != nil
    #   erb:'/destination/new'
    # else
    #   redirect '/login'
    # end
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
 #   @user = User.find(session[:user_id])
 #   if params[:city].empty? #|| params[:country].empty? || params[:description].empty?
 #     redirect '/destination/new'
 #   else
 #   @user.destinations << Destination.new(params[:destinations])
 #   redirect "/user/#{@user.slug}"
 # end
 if logged_in?
    if Destination.new(params[:destinations]).valid?
      @destination = current_user.destinations.build(params[:destinations])
      @destination.save
      redirect to "/destination"
    else
      redirect to "/destination/new"
    end
  end
end

#  get '/destination/:id' do
#    if session[:user_id] != nil
#     @destinations = Destination.find(params[:user_id])
#     #binding.pry
#     erb :'/destination/show' #want to show destinations of user
#   else
#     redirect '/login'
#   end
# end

get '/destination/:slug' do
   @destination = Destination.find_by_slug(params[:slug])
   erb :'destination/show'
 end

  # post '/destination/:slug' do
  #   redirect "/destination/#{params[:user_id]}"
  # end

  get '/destination/:slug/edit' do
    @destination = Destination.all
   if logged_in?
     @destination = Destination.find(params[:slug])
     if @destination && @destination.user == current_user
       erb :'destination/edit'
     else
       redirect '/destination'
     end
   else
     redirect '/login'
   end

 end


  patch '/destination/:slug' do
  #   @destinations = Destination.find(params[:user_id])
  #   @destinations.update(city: params[:city], country: params[:country], rating: params[:rating], description: params[:description])
  #   redirect "/destination/#{@destinations.user_id}"
  # end
  if logged_in?
      @destination = Destination.find_by_slug(params[:slug])
      if @destination && @destination.user == current_user
        if @destination.update(params[:destinations]) != true
          redirect to '/destination/new'
        end
      else
        erb :'user/login'
      end
      erb :'destination/show'
    end

    delete '/destination/:slug/delete' do
        if logged_in?
          @destination = Destinations.find_by_slug(params[:slug])
          if @destination.user_id == current_user.id
            @destination.delete
            redirect to '/destination'
          else
            redirect to '/destination'
          end
        else
          redirect to '/login'
        end
      end
    end
  end
