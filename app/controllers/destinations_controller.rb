class DestinationsController < ApplicationController

    get "/destination" do
  # if logged_in?
  #   @user = User.find(session[:user_id])
  #   @destination = Destination.all
  # else
  #   redirect '/login'
  # end
  # erb :"/destination/show"
  @destination = Destination.all
  erb :'/destination/show'
  end

  get "/destination/new" do
  if logged_in?
    @user = User.find(session[:user_id])
  else
    redirect '/login'
  end

  erb :"/destination/new"
end

    post '/destination' do
 if !logged_in?
      redirect to '/login'
    end

    if params[:city] != ""
      @destination = Destination.create(city: params[:city], user_id: current_user.id)

      redirect to "/destination/#{@destination.id}"
    else
      redirect to '/destination/new'
    end
end

        get '/destination/:id' do
          @destination = Destination.find_by(id: params[:id])
          erb :'/destination/show'
        end

    get '/destination/:id/edit' do
        @destination = Destination.find_by(id: params[:id])
   if logged_in?
     if @destination.user == current_user
       erb :'/destination/edit'
     else
       redirect "/user/#{@destination.id}"
     end
   else
     redirect '/login'
   end
  end


  patch '/destination/:id' do
      @destination = Destination.find(id: params[:id])
      if logged_in?
  if @destination.user == current_user && params[:city] != ""

     @destination.update(city: params[:city])
     redirect to "/destination/#{@destination.id}"
  else
     redirect to "/user/#{@destination.id}"
  end
else
  redirect to '/login'
end
end

  delete '/destination/:id' do
    @destination = Destination.find(id: params[:id])
    if @destination.user == current_user
      @destination.destroy
      redirect to '/destination'
    else
      redirect to '/destination'
    end
  end
