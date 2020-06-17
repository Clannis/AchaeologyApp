describe SessionController do
    
    describe "Sign Up" do

        describe "Logged Out" do
                
            before do
                get '/logout'
            end

            it "loads the signup page" do
                get '/signup'
                expect(last_response.status).to eq(200)
            end

            it "does not let a user sign up without a username" do
                params = {
                    username: "",
                    email: "fake@email.com",
                    password: "password",
                    password_confirmation: "password",
                    name: "Fake Name"
                }

                post "/signup", params
                expect(last_response.body).to include("Field is empty")
            end

            it "does not let a user sign up without an email" do
                params = {
                    username: "clannis",
                    email: "",
                    password: "password",
                    password_confirmation: "password",
                    name: "Fake Name"
                }

                post "/signup", params
                expect(last_response.body).to include("Field is empty")
            end

            it "does not let a user sign up without an actual email" do
                params = {
                    username: "clannis",
                    email: "fakeemail",
                    password: "password",
                    password_confirmation: "password",
                    name: "Fake Name"
                }

                post "/signup", params
                expect(last_response.body).to include("Email must be a real email address")
            end

            it "does not let a user sign up without a password" do
                params = {
                    username: "clannis",
                    email: "fake@email.com",
                    password: "",
                    password_confirmation: "",
                    name: "Fake Name"
                }

                post "/signup", params
                expect(last_response.body).to include("Field is empty")
            end

            it "does not let a user sign up without too short of a password" do
                params = {
                    username: "clannis",
                    email: "fake@email.com",
                    password: "123",
                    password_confirmation: "123",
                    name: "Fake Name"
                }

                post "/signup", params
                expect(last_response.body).to include("Password is too short (minimum is 6 characters)")
            end

            it "does not let a user sign up without too long of a password" do
                params = {
                    username: "clannis",
                    email: "fake@email.com",
                    password: "123456789012345678901",
                    password_confirmation: "123456789012345678901",
                    name: "Fake Name"
                }

                post "/signup", params
                expect(last_response.body).to include("Password is too long (maximum is 20 characters)")
            end

            it "does not let a user sign up without a name" do
                params = {
                    username: "clannis",
                    email: "fake@email.com",
                    password: "password",
                    password_confirmation: "password",
                    name: ""
                }

                post "/signup", params
                expect(last_response.body).to include("Field is empty")
            end
            
        end
        
        describe "Logged In" do
            
            it 'sign up directs user to dig page index' do
                get '/logout'

                params = {
                    username: "clannis",
                    email: "fake@email.com",
                    password: "password",
                    password_confirmation: "password",
                    name: "Fake Name"
                }
                
                post "/signup", params
                expect(last_response.location).to include("/dig_sites")
            end
            
            it 'does not let a logged in user view the signup page' do
                get '/logout'

                User.create(username: "clannis", email: "fake@email.com", password: "password", name: "Fake Name")

                params = {
                :user => "clannis",
                :password => "password"
                }
                post '/login', params
                get '/signup'
                expect(last_response.location).to include("/dig_sites")
            end
        end

        # it "creates new user" do
        #     get '/signup'

        # end
    end
end
