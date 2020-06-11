class DigSiteController < ApplicationController

    get "/dig_sites/index" do
        @user = current_user
        erb :"/dig_sites/index"
    end

    get "/dig_sites/:id" do
        @dig_site = DigSite.find(params[:id])
        erb :"/dig_sites/show"
    end

    get "/dig_sites/:id/edit" do
        @dig_site = DigSite.find(params[:id])
        erb :"/dig_sites/edit"
    end
    
end