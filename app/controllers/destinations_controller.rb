class DestinationsController < ApplicationController

    get '/destination' do
      @destinations = Destination.all
      erb :'/user/show'
    end

    post '/destination' do
 if params[:city] == ""
  redirect "/destination/new"
  else
    user = User.find_by_id(session[:user_id])
    destination= Destination.create(params)
    destination.user = user
    destination.save
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
      @destination = Destination.find_by(id: params[:id])
      erb :'/destination/show'
  end

  # get '/destination/:id/edit' do
  #   if logged_in?
  #     @destination = Destination.find(params[:id])
  #     if @destination.user_id == current_user.id
  #       erb :'destination/edit'
  #     else
  #       redirect '/destination/:id'
  #     end
  #   else
  #     redirect '/login'
  #   end
  # end
  #
  # patch '/destination/:id' do
  #   @destination = Destination.find(params[:id])
  #   @destination.update(city: params[:city], country: params[:country], rating: params[:rating], description: params[:description])
  #   erb :'/destination/show'
  #   redirect "/destination/#{@destination.id}"
  # end


    get '/destination/:id/edit' do
   if logged_in?
     if Destination.find(params[:id]).user.id == session[:user_id]
       @destination = Destination.find(params[:id])
       @user = @destination.user
       erb :"/destination/edit"
     else
       redirect '/destination'
     end
   else
     redirect '/login'
   end
  end


    patch '/destination/:id/edit' do
      @destination = Destination.find(params[:id])
 if params[:city].empty?
   redirect "/destination/#{@destination.id}/edit"
 else
   if @destination.update(city: params[:city], country: params[:country], rating: params[:rating], description: params[:description] )
     redirect "/destination/#{@destination.id}"
   else
     redirect "/destination/#{@destination.id}"
   end
 end
end

    delete '/destination/:id/delete' do
      if Destination.find(params[:id]).user.id == session[:user_id]
    @destination = Destination.find(params[:id])
    @destination.destroy
    redirect "/destination"
  else
    redirect '/destination'
  end
    end

  end
