# Uncomment the following for process monitoring via God

# God.watch do |w|
#   w.name    = 'runaround-worker'
#   w.group   = 'runaround'
#   w.uid     = 'sfadmin'
#   w.gid     = 'sfadmin'
#   w.dir     = '/var/www/vhosts/runaround/current'
#   w.log     = "#{w.dir}/log/#{w.name}.log"
#   w.err_log = "#{w.dir}/log/#{w.name}_error.log"

#   # Set correct environment for node apps
#   #w.env     = { "NODE_ENV" => "production" }

#   # Example start command for node app.
#   w.start   = "/usr/local/bin/node app.js"

#   # Example start command for rails worker.
#   # w.start = "bundle exec rake environment resque:work"

#   w.keepalive
# end