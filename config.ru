require './config/environment'

use Rack::MethodOverride
use ArtifactController
use DigSiteController
use LevelController
use UnitController
use UserController
run ApplicationController