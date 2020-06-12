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
                redirect "/levels/#{@level.id}/artifact/new"
            end
        else
            redirect "/levels/#{@level.id}/artifact/new"
        end
    end

end