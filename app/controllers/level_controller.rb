class LevelController < ApplicationController

    get "/units/:id/levels/new" do
        @unit = Unit.find(params[:id])
        erb :"/levels/new"
    end

    get "/levels/:id" do
        @level = Level.find(params[:id])
        erb :"/levels/show"
    end

    post "/units/:id/levels/new" do
        @unit = Unit.find(params[:id])
        @level = Level.new(local_id: params[:local_id], beg_depth: params[:beg_depth], end_depth: params[:end_depth], unit_id: @unit.id)
        exists = false
        @unit.levels.each do |unit|
            if unit.local_id == @unit.local_id
                exists = true
            end
        end

        if !exists
            if @level.save
                redirect "/levels/#{@level.id}"
            else
                redirect "/units/#{@unit.id}/levels/new"
            end
        else
            redirect "/units/#{@unit.id}/levels/new"
        end
    end

    get "/levels/:id/edit" do
        @level = Level.find(params[:id])
        erb :"/levels/edit"
    end

    patch "/levels/:id" do
        @level = Level.find(params[:id])

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
        if current_user.id = @dig_site.user_id
            @level.destroy
        end
        redirect "/units/#{@level.unit.id}"
    end
    
end