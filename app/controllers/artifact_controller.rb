class ArtifactController < ApplicationController
    
    get "/artifacts/:id" do
        @artifact = Artifact.find(params[:id])
        @unit = @artifact.level
        @index = 0
        while @unit.artifacts[@index] != @artifact do
            @index += 1
        end
        erb :"/artifacts/show"
    end
end