class UserController < ApplicationController

    get "/users/:id" do
      authenticate
      @user = current_user
      erb :"/users/show"
    end

    get "/users/:id/edit" do
      authenticate
      @user = User.find(params[:id])
      erb :"/users/edit"
    end

    patch "/users/:id" do
      authenticate
      @user = User.find(params[:id])
      if @user == current_user
        if !params[:name].empty?
          @user.name = params[:name]
        end
        if !params[:email].empty?
          @user.email = params[:email]
        end
        if !params[:new_password].empty?
          @user.update(password: params[:new_password], password_confirmation: params[:new_password_confirmation])
        end
        if @user && @user.authenticate(params[:password])
          @user.save
          if @user.errors.any?
            erb :"/users/edit"
          else
            redirect "/users/#{current_user.id}"
          end
        else
          erb :"/users/edit"
        end 
      else
        erb :"/users/edit"
      end
    end
    
end