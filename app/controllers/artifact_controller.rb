class ArtifactController < ApplicationController

    get "/levels/:id/artifacts/new" do
        @level = Level.find(params[:id])
        erb :"/artifacts/new"
    end
    
    get "/artifacts/:id" do
        @artifact = Artifact.find(params[:id])
        @unit = @artifact.level
        @index = 0
        while @unit.artifacts[@index] != @artifact do
            @index += 1
        end
        erb :"/artifacts/show"
    end

    post "/levels/:id/artifacts/new" do
        @level = Level.find(params[:id])
        @artifact = Artifact.new(local_id: params[:local_id], artifact_type: params[:artifact_type], description: params[:description], level_id: @level.id)
        exists = false
        @level.artifacts.each do |artifact|
            if artifact.local_id == @artifact.local_id
                exists = true
            end
        end

        if !exists
            if @artifact.save
                redirect "/artifacts/#{@artifact.id}"
            else
                redirect "/levels/#{@level.id}/artifacts/new"
            end
        else
            redirect "/levels/#{@level.id}/artifacts/new"
        end
    end

    get "/artifacts/:id/edit" do
        @artifact = Artifact.find(params[:id])
        erb :"/artifacts/edit"
    end

    patch "/artifacts/:id" do
        @artifact = Artifact.find(params[:id])

        if !params[:local_id].empty?
            @level = @artifact.level
            exists = false
            
            @level.artifacts.each do |artifact|
                if artifact.local_id == params[:local_id]
                    exists = true
                end
            end

            if !exists
                @artifact.local_id = params[:local_id]
            else
                @error = "Artifact ID already exits"
            end
        end
        if !params[:artifact_type].empty?
            @artifact.artifact_type = params[:artifact_type]
        end
        if !params[:description].empty?
            @artifact.description = params[:description]
        end
        @artifact.save

        redirect :"/artifacts/#{@artifact.id}"
    end

    delete "/artifacts/:id" do
        authenticate
        @artifact = Artifact.find(params[:id])
        @dig_site = @artifact.level.unit.dig_site
        if current_user.id = @dig_site.user_id
            @level.destroy
        end
        redirect "/level/#{@artifact.level.id}"
    end
    
end