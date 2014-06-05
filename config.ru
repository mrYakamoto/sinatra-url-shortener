# Require config/environment.rb
require ::File.expand_path('../config/environment',  __FILE__)

set :app_file, __FILE__

configure do
  # See: http://www.sinatrarb.com/faq.html#sessions
  enable :sessions
  set :session_secret, ENV['SESSION_SECRET'] || 'this is a secret shhhhh'

  # :method_override allows us to use the other HTTP verbs like PUT, & DELETE
  # by sending up a parameter _method in a POST request.
  # Where _method == PUT or DELETE
  set :method_override, true

  # Set the views to 
  set :views, File.join(Sinatra::Application.root, "app", "views")
end

run Sinatra::Application
