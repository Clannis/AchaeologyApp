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
            exists = false
            DigSite.all.each do |dig_site|
                if dig_site.name == params[:name]
                    exists = true
                end
            end
            if !exists
                @dig_site.name = params[:name]
            else
                @dig_site.errors.add(:name, "already exists")
            end
        end
        if !params[:location].empty?
            @dig_site.location = params[:location]
        end
        if !params[:owner].empty?
            @dig_site.user_id = User.find_by_name(slug(params[:owner])).id
        end
        if !@dig_site.errors.any?
            @dig_site.save
            redirect :"/dig_sites"
        else
            erb :"/dig_sites/edit"
        end
    end

    post "/dig_sites" do
        authenticate
        @dig_site = DigSite.new()
        if !params[:name].empty? && !params[:location].empty?
            exists = false
            DigSite.all.each do |dig_site|
                if dig_site.name == params[:name]
                    exists = true
                end
            end
            if !exists
                @dig_site.name = params[:name]
                @dig_site.location = params[:location]
                @dig_site.user_id = current_user.id
                if @dig_site.save
                    redirect "/dig_sites/#{@dig_site.id}"
                else
                    erb :"/dig_sites/new"
                end
            else
                @dig_site.errors.add(:name, "already exists")
                erb :"/dig_sites/new"
            end
        else
            @dig_site.errors.add(:field, "is empty.")
            erb :"/dig_sites/new"
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