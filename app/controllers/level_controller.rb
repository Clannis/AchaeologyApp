class LevelController < ApplicationController

    get "/units/:id/levels/new" do
        authenticate
        @unit = Unit.find(params[:id])
        ownership(@unit.dig_site)
        erb :"/levels/new"
    end

    get "/levels/:id" do
        authenticate
        @level = Level.find(params[:id])
        ownership(@level.unit.dig_site)
        @object = @level
        erb :"/levels/show"
    end

    post "/units/:id/levels/new" do
        authenticate
        @unit = Unit.find(params[:id])
        ownership(@unit.dig_site)
        @level = Level.new(local_id: params[:local_id], beg_depth: params[:beg_depth], end_depth: params[:end_depth], unit_id: @unit.id)
        exists = false
        @unit.levels.each do |level|
            if level.local_id == @level.local_id
                exists = true
            end
        end

        if !exists
            if @level.save
                redirect "/levels/#{@level.id}"
            else
                erb :"/levels/new"
            end
        else
            erb :"/levels/new"
        end
    end

    get "/levels/:id/edit" do
        authenticate
        @level = Level.find(params[:id])
        ownership(@level.unit.dig_site)
        erb :"/levels/edit"
    end

    patch "/levels/:id" do
        authenticate
        @level = Level.find(params[:id])
        ownership(@level.unit.dig_site)
        if !params[:local_id].empty?
            @unit = @level.unit
            exists = false
            
            @unit.levels.each do |level|
                if level.local_id == params[:local_id]
                    exists = true
                end
            end

            if !exists
                @level.local_id = params[:local_id]
            else
                @error = "Level ID already exits"
            end
        end
        if !params[:beg_depth].empty?
            @level.beg_depth = params[:beg_depth]
        end
        if !params[:end_depth].empty?
            @level.end_depth = params[:end_depth]
        end
        @level.save

        redirect :"/levels/#{@level.id}"
    end

    delete "/levels/:id" do
        authenticate
        @level = Level.find(params[:id])
        @dig_site = @level.unit.dig_site
        ownership(@dig_site)
        @level.artifacts.each do |artifact|
            artifact.destroy
        end
        @level.destroy
        redirect "/units/#{@level.unit.id}"
    end
    
end