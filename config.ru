require './config/environment'

use Rack::MethodOverride
use RunsController
use UsersController
run ApplicationController
