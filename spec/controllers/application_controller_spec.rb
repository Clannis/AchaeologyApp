require 'spec_helper'

describe ApplicationController do

    describe "Homepage" do
        
        before do
            get '/logout'
        end

        it 'loads the homepage' do
            get '/'
            expect(last_response.status).to eq(200)
            expect(last_response.body).to include("Welcome to AADB!")
        end
    end
end

