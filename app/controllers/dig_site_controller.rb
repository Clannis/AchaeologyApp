class DigSiteController < ApplicationController

    get "/dig_sites" do
        authenticate
        @user = current_user
        erb :"/dig_sites/index"
    end

    get "/dig_sites/new" do
        authenticate
        erb :"/dig_sites/new"
    end

    get "/dig_sites/:id" do
        authenticate
        @dig_site = DigSite.find(params[:id])
        ownership(@dig_site)
        @object = @dig_site
        erb :"/dig_sites/show"
    end

    get "/dig_sites/:id/edit" do
        authenticate
        @dig_site = DigSite.find(params[:id])
        ownership(@dig_site)
        erb :"/dig_sites/edit"
    end

    patch "/dig_sites/:id" do
        authenticate
        @dig_site = DigSite.find(params[:id])
        ownership(@dig_site)
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

    post "/dig_sites/new" do
        authenticate
        @dig_site = DigSite.new(name: params[:name], location: params[:location], user_id: current_user.id )
        if @dig_site.save
            redirect "/dig_sites/#{@dig_site.id}"
        else
            redirect "/dig_sites/new"
        end
    end

    delete "/dig_sites/:id" do
        authenticate
        @dig_site = DigSite.find(params[:id])
        ownership(@dig_site)
        @dig_site.artifacts.each do |artifact|
            artifact.destroy
        end
        @dig_site.levels.each do |level|
            level.destroy
        end
        @dig_site.units.each do |unit|
            unit.destroy
        end
        @dig_site.destroy
        redirect "/dig_sites" 
    end
    
end