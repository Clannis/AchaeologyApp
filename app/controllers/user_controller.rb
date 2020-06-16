class UserController < ApplicationController

    get "/users/:id" do
      @user = current_user
      erb :"/users/show"
    end

    get "/users/:id/edit" do
      @user = User.find(params[:id])
      erb :"/users/edit"
    end

    patch "/users/:id" do
      @user = User.find(params[:id])
      if @user == current_user
        if !params[:name].empty?
          @user.name = params[:name]
        end
        if !params[:email].empty?
          @user.email = params[:email]
        end
        @user.save
        redirect "/user/#{current_user.id}"
      else
        error
        redirect "/user/#{current_user.id}"
      end
    end
    
end