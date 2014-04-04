get '/' do
  # Since this app doesn't have a homepage, send all users to
  # the urls#index action
  redirect "/urls"
end
