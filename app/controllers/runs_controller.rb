class RunsController < ApplicationController

  get '/runs/home' do
    if logged_in?
      @runs = Run.all
      erb :'/runs/home'
    else
      redirect '/user/login'
    end
  end

  get '/runs/new' do
    if logged_in?
      erb :'runs/new'
    else
      redirect '/user/login'
    end
  end

  post '/runs/new' do
    if params[:time] == "" || params[:distance] == "" || params[:description] == ""
    erb :'runs/new', locals: {message: "Please enter data in every field"}
    else
      @run = Run.create(:time => params[:time], :distance => params[:distance], :description => params[:description], :user_id => current_user.id)
    redirect "/runs/#{@run.id}"
    end
  end

  get '/runs/:id' do
    if logged_in?
      @run = Run.find_by_id(params[:id])
      if current_user.id == @run.user_id
        erb :'runs/show'
      else
        redirect '/runs/home'
      end
    else
      redirect 'users/login'
    end
  end

  post '/runs/:id' do
    @run = Run.find_by_id(params[:id])
    if current_user.id == @run.user_id
      @run = Run.find_by_id(params[:id])
      @run.time = params[:time]
      @run.distance = params[:distance]
      @run.description = params[:description]
      @run.save
      redirect "/runs/#{@run.id}"
    else
      redirect '/'
    end
  end

  get '/runs/:id/:edit' do
    if logged_in?
      @run = Run.find_by_id(params[:id])
      if current_user.id == @run.user_id
        erb :'runs/edit'
      else
        redirect '/runs/home'
      end
    else
      redirect '/login'
    end
  end

  post '/runs/:id/delete' do
    @run = Run.find(params[:id])
    @user = current_user
    if logged_in?
      if @run.user_id == current_user.id
        @run.delete
        redirect '/runs/home'
      else
        redirect '/runs/home'
      end
    end
  end

end
