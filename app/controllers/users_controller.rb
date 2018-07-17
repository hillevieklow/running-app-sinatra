class UsersController < ApplicationController
  get '/signup' do
    erb :'users/signup'
  end

  post '/signup' do
   if params[:username] == "" || params[:email] == "" || params[:password] == ""
     erb :'users/signup'
    else
     @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
     session[:user_id] = @user.id
     redirect '/runs/home'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/runs/home'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect "/runs/home"
  else
    erb :'users/signup'
   end
 end

end
