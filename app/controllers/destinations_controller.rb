class DestinationsController < ApplicationController

    get '/destination' do
      @destinations = Destination.all
      erb :'/user/show'
    end

    post '/destination' do
 if params[:city].empty?
    redirect "/destination/new"
  else
    user = User.find_by_id(session[:user_id])
    destination = Destination.create(params)
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

    get '/destination/:id/edit' do
      # find_destination
      # if logged_in?
      #   if @destination.user == current_user
      #      erb :'/destination/edit'
      #   else
      #      redirect to "/user/#{@destination.id}"
      #   end
      # else
      #  redirect to '/'
      # end
  #     #2nd attemp below
  #  #    if logged_in?
  #  #   @destination = Destination.find(params[:user_id])
  #  #   if @destination.user_id == current_user.user_id
  #  #     erb :'destination/edit'
  #  #   else
  #  #     redirect '/destination'
  #  #   end
  #  # else
  #  #   redirect '/login'
  #  # end
  #  #
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


    # get "/destination/:id/edit" do
    #     if logged_in?
    #       if Destination.find(params[:id]).user.id == session[:user_id]
    #         @destination = Destination.find(params[:id])
    #         @user = @destination.user
    #         erb :"/destination/edit"
    #       else
    #         redirect '/destination/edit'
    #       end
    #     else
    #       redirect '/login'
    #     end
    #   end



    patch '/destination/:id/edit' do
      @destination = Destination.find(params[:id])
 if params[:city].empty? || params[:country].empty? || params[:rating].empty? || params[:description].empty?
   redirect "/destination/#{@destination.id}/edit"
 else
   if @destination.update(city: params[:city], country: params[:country], rating: params[:rating], description: params[:description] )
     redirect "/destination/#{@destination.id}"
   else
     redirect "/destination/#{@destination.id}/edit"
   end
 end
end

    delete '/destination/:id/delete' do
      find_destination
      if Destination.find(params[:id]).user.id == session[:user_id]
    @destination = Destination.find(params[:id])
    @destination.destroy
    redirect "/destination"
  else
    redirect '/destination'
  end
    end


    def find_destination
      @destination = Destination.find_by(id: params[:id])
    end

end
