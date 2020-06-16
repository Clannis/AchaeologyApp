class UnitController < ApplicationController
    
    get "/dig_sites/:id/units/new" do
        authenticate
        @dig_site = DigSite.find(params[:id])
        ownership(@dig_site)
        erb :"/units/new"
    end

    get "/units/:id" do
        authenticate
        @unit = Unit.find(params[:id])
        ownership(@unit.dig_site)
        @object = @unit
        erb :"/units/show"    
    end

    post "/dig_sites/:id/units/new" do
        authenticate
        @dig_site = DigSite.find(params[:id])
        ownership(@dig_site)
        @unit = Unit.new(size: params[:size], local_id: params[:local_id], dig_site_id: @dig_site.id)
        exists = false
        @dig_site.units.each do |unit|
            if unit.local_id == @unit.local_id
                exists = true
            end
        end

        if !exists
            if @unit.save
                redirect "/units/#{@unit.id}"
            else
                redirect "/dig_site/#{@dig_site.id}/units/new"
            end
        else
            redirect "/dig_site/#{@dig_site.id}/units/new"
        end
    end

    get "/units/:id/edit" do
        authenticate
        @unit = Unit.find(params[:id])
        ownership(@unit.dig_site)
        erb :"/units/edit"
    end

    patch "/units/:id" do
        authenticate
        @unit = Unit.find(params[:id])
        ownership(@unit.dig_site)
        if !params[:local_id].empty?
            @dig_site = @unit.dig_site
            exists = false
            
            @dig_site.units.each do |unit|
                if unit.local_id == params[:local_id]
                    exists = true
                end
            end

            if !exists
                @unit.local_id = params[:local_id]
            else
                @error = "Unit ID already exits"
            end
        end
        if !params[:size].empty?
            @unit.size = params[:size]
        end
        @unit.save

        redirect :"/units/#{@unit.id}"
    end
 
    delete "/units/:id" do
        authenticate
        @unit = Unit.find(params[:id])
        @dig_site = @unit.dig_site
        ownership(@dig_site)
        @unit.artifacts.each do |artifact|
            artifact.destroy
        end
        @unit.levels.each do |level|
            level.destroy
        end
        @unit.destroy
        redirect "/dig_sites/#{@dig_site.id}"
    end

end