set :user, "punit"
set :application, "carekaro"
set :domain, "punit@carekaro.com"
set :repository,  "git@github.com:amitrathore/careppl.git"
set :chmod755, "app config db lib public vendor script script/* public/disp*"
set :use_sudo, false 
set :deploy_to, "/home/punit/app/carekaro"
set :scm, :git
set :branch, "master"
#set :mongrel_port, "4000"
#set :mongrel_nodes, "3"

set :ssh_options, { :forward_agent => true }

set :runner, nil
role :app, "carekaro.com"
role :web, "carekaro.com"
role :db, "carekaro.com", :primary => true


#task :after_symlink do
#  invoke_command "chmod 744 #{current_path}/script/process/reaper"
#end

#set :port, 30000

# If you have previously been relying upon the code to start, stop 
# and restart your mongrel application, or if you rely on the database
# migration code, please uncomment the lines you require below

# If you are deploying a rails app you probably need these:

# load 'ext/rails-database-migrations.rb'
# load 'ext/rails-shared-directories.rb'

# There are also new utility libaries shipped with the core these 
# include the following, please see individual files for more
# documentation, or run `cap -vT` with the following lines commented
# out to see what they make available.

# load 'ext/spinner.rb'              # Designed for use with script/spin
# load 'ext/passenger-mod-rails.rb'  # Restart task for use with mod_rails
# load 'ext/web-disable-enable.rb'   # Gives you web:disable and web:enable

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion
# see a full list by running "gem contents capistrano | grep 'scm/'"
