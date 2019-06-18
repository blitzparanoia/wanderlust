class DestinationsController < ApplicationController

    get '/destination' do
      @destinations = Destination.all
      erb :'/user/show'
    end

    post '/destination' do
 #   @user = User.find(session[:user_id])
 #   if params[:city].empty? || params[:country].empty? || params[:description].empty?
 #     redirect '/destination/new'
 #   else
 #   @user.destinations << Destination.new(params[:destinations])
 #   redirect "/user/#{@user.id}"
 # end

 if params[:city].empty?
    redirect "/destination/new"
  else
    user = User.find_by_id(session[:user_id])
    destination = Destination.create(params)
    destination.user = user
    destination.save
    # redirect "/tweets/:#{tweet.id}"
    redirect "/destination"
  end
end


    get '/destination/new' do
      erb :'/destination/new'
    end

    post '/destination/new' do
        if session[:user_id] != nil
          redirect '/destination/new'
        else
        redirect '/login'
     end
    end

    get '/destination/:id' do
      find_destination
      erb :'/destination/show'
    end

    get '/destination/:id/edit' do
      find_destination
      # if logged_in?
      #   if @destination.user == current_user
      #      erb :'/destination/edit'
      #   else
      #      redirect to "/user/#{@destination.id}"
      #   end
      # else
      #  redirect to '/'
      # end
      #2nd attemp below
   #    if logged_in?
   #   @destination = Destination.find(params[:user_id])
   #   if @destination.user_id == current_user.user_id
   #     erb :'destination/edit'
   #   else
   #     redirect '/destination'
   #   end
   # else
   #   redirect '/login'
   # end
   if logged_in?
     if Destination.find(params[:id]).user.id == session[:user_id]
       @destination = Destination.find(params[:id])
       @user = @destination.user
       erb :"/destination/edit"
     else
       redirect '/destination/edit'
     end
   else
     redirect '/login'
   end
    end

    patch '/destination/:id' do
      find_destination
      if logged_in?
        if @destination.user == current_user && params[:city] != "" && params[:country] != "" && params[:rating] != "" && params[:description] != ""

           @destination.update(city: params[:city], country: params[:country], rating: params[:rating], description: params[:description] )
           redirect to "/destination/#{@destination.id}"
        else
           redirect to "/user/#{@destination.id}"
        end
      else
        redirect to '/'
      end
    end

    delete '/destination/:id' do
      find_destination
      if @destination.user == current_user
        @destination.destroy
        redirect to '/destination'
      else
        redirect to '/destination'
      end
    end


    def find_destination
      @destination = Destination.find_by(id: params[:id])
    end
end
