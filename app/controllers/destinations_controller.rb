class DestinationsController < ApplicationController

    get "/destination" do
  if logged_in?
    @user = User.find(session[:user_id])
    @place = Destination.all
  else
    redirect '/login'
  end
  erb :"/destination/show"
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

#
#     post '/destination/new' do
#         if session[:user_id] != nil
#           redirect '/destination/new'
#         else
#         redirect '/login'
#      end
#     end
#
#     get '/destination/:id' do
#       if logged_in?
#       @destination = Destination.find_by(params[:id])
#       erb :'/destination/show'
#     else
#       redirect '/login'
#     end
#   end
#
#
#     get '/destination/:id/edit' do
#    if logged_in?
#      if Destination.find(params[:id]).user.id == session[:user_id]
#        @destination = Destination.find(params[:id])
#        @user = @destination.user
#        erb :"/destination/edit"
#      else
#        redirect '/destination'
#      end
#    else
#      redirect '/login'
#    end
#   end
#
#
#   patch '/destination/:id' do
#       @destination = Destination.find(params[:id])
#       @destination.update(city: params[:city])
#       @destination.save
#       #redirect "/destination/"
#       erb :"/destination/#{@destination.id}/show"
#   end
#
#
#     delete '/destination/:id/delete' do
#       if Destination.find(params[:id]).user.id == session[:user_id]
#     @destination = Destination.find(params[:id])
#     @destination.destroy
#     redirect "/destination"
#   else
#     redirect '/destination'
#   end
# end

  end
