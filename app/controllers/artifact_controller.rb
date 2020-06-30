class ArtifactController < ApplicationController

    get "/levels/:id/artifacts/new" do
        authenticate
        @level = Level.find(params[:id])
        ownership(@level.unit.dig_site)
        erb :"/artifacts/new"
    end
    
    get "/artifacts/:id" do
        authenticate
        @artifact = Artifact.find(params[:id])
        @level = @artifact.level
        ownership(@level.unit.dig_site)
        @object = @artifact
        @index = 0
        while @level.artifacts[@index] != @artifact do
            @index += 1
        end
        erb :"/artifacts/show"
    end

    post "/levels/:id/artifacts/new" do
        authenticate
        @level = Level.find(params[:id])
        @dig_site = @level.unit.dig_site
        ownership(@dig_site)
        @artifact = Artifact.new()
        if !params[:local_id].empty? && !params[:artifact_type].empty? && !params[:description].empty?
            if params[:description] == "Enter description here..."
                @artifact.errors.add(:description, "must be altered.")
                erb :"/artifacts/new"
            else
                @artifact = Artifact.new(local_id: params[:local_id], artifact_type: params[:artifact_type], description: params[:description], level_id: @level.id)
                exists = false
                @dig_site.artifacts.each do |artifact|
                    if artifact.local_id == @artifact.local_id
                        exists = true
                    end
                end

                if !exists
                    if @artifact.save
                        redirect "/artifacts/#{@artifact.id}"
                    else
                        erb :"/artifacts/new"
                    end
                else
                    @artifact.errors.add(:id, "already exists")
                    erb :"/artifacts/new"
                end
            end
        else
            @artifact.errors.add(:field, "is empty.")
            erb :"/artifacts/new"
        end
    end

    get "/artifacts/:id/edit" do
        authenticate
        @artifact = Artifact.find(params[:id])
        ownership(@artifact.level.unit.dig_site)
        erb :"/artifacts/edit"
    end

    patch "/artifacts/:id" do
        authenticate
        @artifact = Artifact.find(params[:id])
        ownership(@artifact.level.unit.dig_site)
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
                @artifact.errors.add(:id, "already exists")                
            end
        end
        if !params[:artifact_type].empty?
            @artifact.artifact_type = params[:artifact_type]
        end
        if !params[:description].empty?
            @artifact.description = params[:description]
        end
        if !@artifact.errors.any?
            @artifact.save
            redirect :"/artifacts/#{@artifact.id}"
        else
            erb :"/artifacts/edit"
        end
    end

    delete "/artifacts/:id" do
        authenticate
        @artifact = Artifact.find(params[:id])
        @level = @artifact.level
        @dig_site = @artifact.level.unit.dig_site
        ownership(@dig_site)
        @artifact.destroy
        redirect "/levels/#{@level.id}"
    end

    get "/dig_sites/:id/artifacts/index" do
        @dig_site = DigSite.find(params[:id])
        @artifacts = @dig_site.artifacts.sort_by &:created_at
        erb :"/artifacts/index"
    end
    
end