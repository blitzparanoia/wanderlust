class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to '/destination'
    else
      erb :"user/new"
  end
end

end
