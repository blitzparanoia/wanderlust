class DestinationsController < ApplicationController

  get "/destination" do
    @destination = Destination.all
    erb :'/destination/show'
  end


  get "/destination/new" do
    erb :"/destination/new"
  end


  post '/destination' do
    if !logged_in
      redirect "/"
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
    erb :'/destination/show'
  end

  
#
#     get '/destination/:id/edit' do
#         @destination = Destination.find_by(id: params[:id])
#    if logged_in?
#      if @destination.user == current_user
#        erb :'/destination/edit'
#      else
#        redirect "/user/#{@destination.id}"
#      end
#    else
#      redirect '/login'
#    end
#   end
#
#
#   patch '/destination/:id' do
#       @destination = Destination.find(id: params[:id])
#       if logged_in?
#   if @destination.user == current_user && params[:city] != ""
#
#      @destination.update(city: params[:city])
#      redirect to "/destination/#{@destination.id}"
#   else
#      redirect to "/user/#{@destination.id}"
#   end
# else
#   redirect to '/login'
# end
# end
#
#   delete '/destination/:id' do
#     @destination = Destination.find(id: params[:id])
#     if @destination.user == current_user
#       @destination.destroy
#       redirect to '/destination'
#     else
#       redirect to '/destination'
#     end
  end
