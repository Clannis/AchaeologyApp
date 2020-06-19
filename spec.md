# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
    sinatra gem is installed through bundler
- [x] Use ActiveRecord for storing information in a database
    application_controller inherits from ActiveRecord::Base
- [x] Include more than one model class (e.g. User, Post, Category)
    User > DigSite > Unit > Level > Artifact (Each ">" represents has_many : belongs_to)
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts)
    all relationships are has_many : belongs_to
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)
    all relationships are has_many : belongs_to
- [x] Include user accounts with unique login attribute (username or email)
    both username and email are required to be unique
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
    all resources can be created, updated, shown, and deleted
- [x] Ensure that users can't modify content created by other users
    authenticate logged in at every route and verify ownership with every update or delete
- [X] Include user input validations
    certain fields are required at object creation and some must be unique based on different criteria
- [X] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
    errors are displayed
- [X] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code
    README has been filled out

Confirm
- [x] You have a large number of small Git commits
    over 100
- [x] Your commit messages are meaningful
    tells what the commit is about
- [x] You made the changes in a commit that relate to the commit message
    mostly true - some commits were far appart and hold a few different changes (may have forgotten all that was ccompleted in that commit and therefore wasnt included in the message)
- [x] You don't include changes in a commit that aren't related to the commit message
    minus db refreshes/changes
