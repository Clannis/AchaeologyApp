class DigSiteController < ApplicationController

    get "/dig_sites" do
        @user = current_user
        erb :"/dig_sites/index"
    end

    get "/dig_sites/new" do
        erb :"/dig_sites/new"
    end

    get "/dig_sites/:id" do
        @dig_site = DigSite.find(params[:id])
        erb :"/dig_sites/show"
    end

    get "/dig_sites/:id/edit" do
        @dig_site = DigSite.find(params[:id])
        erb :"/dig_sites/edit"
    end

    patch "/dig_sites/:id" do
        @dig_site = DigSite.find(params[:id])
        if !params[:name].empty?
            @dig_site.name = params[:name]
        end
        if !params[:location].empty?
            @dig_site.location = params[:location]
        end
        if !params[:owner].empty?
            @dig_site.user_id = User.find_by_name(slug(params[:owner])).id
        end
        @dig_site.save

        redirect :"/dig_sites"
    end

    
    
end