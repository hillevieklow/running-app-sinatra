class UsersController < ApplicationController
  get '/signup' do
    erb :'users/signup'
  end

  post "/signup" do
    @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    if @user.save && params[:username] != "" && params[:email] != ""
      session[:user_id] = @user.id
      redirect '/runs/home'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    erb :'users/login'
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

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/users' do
    if logged_in?
      @users = User.all
      erb :'users/all'
    else
      redirect '/users/login'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/run_log'
  end

end
