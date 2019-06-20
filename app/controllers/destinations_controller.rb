class DestinationsController < ApplicationController

  get '/destination' do
    @destination = Destination.all
    erb :'/destination/list'
  end


  get "/destination/new" do
    erb :"/destination/new"
  end


  post '/destination' do
    if !logged_in?
      redirect "/" # user needs to be logged in
  end
    if params[:city] != "" || params[:country] != "" || params[:description] != ""
      @destination = Destination.create(city: params[:city], country: params[:country], rating: params[:rating], description: params[:description], user_id: current_user.id)
      redirect "/destination/#{@destination.id}"
    else
      redirect "/destination/new" # not a success
    end
  end


  get '/destination/:id' do
    @destination = Destination.find_by(id: params[:id])
    erb :"/destination/show"
  end


  get '/destination/:id/edit' do
    @destination = Destination.find_by(id: params[:id])
    if logged_in?
      if @destination.user == current_user
       erb :'/destination/edit'
     else
       redirect "/destination/#{@destination.id}"
     end
   else
     redirect '/login' # user needs to be logged in
   end
 end


  patch '/destination/:id' do
    @destination = Destination.find_by(id: params[:id])
    if logged_in?
      if @destination.user == current_user && params[:city] != "" || params[:country] != "" || params[:description] != ""
        @destination.update(city: params[:city], country: params[:country], rating: params[:rating], description: params[:description])
      redirect "/destination/#{@destination.id}" # items are updated
    else
     redirect "/user/#{@destination.id}"
   end
 else
   redirect to '/login' # user not logged in
 end
end

  delete '/destination/:id' do
    @destination = Destination.find_by(id: params[:id])
    if @destination.user == current_user
      @destination.destroy
      redirect '/destination'
    else
      redirect '/destination'
    end
  end
end
