# Resource: Url
#
# action: index
get '/urls' do
  # load all Urls, sorted by their creation time, newest first
  @urls = Url.order("created_at DESC")
  erb :"urls/index"
end

# action: new
get '/urls/new' do
  # The urls/new template depends on a @url instance variable, this is because
  # we render the same template when we fail to save a new Url (see the #create
  # action). This is done primarily to display the errors related to creating
  # the new Url.
  #
  # Since the template requires a @url instance variable, we create one, using
  # an empty (new) Url instance.
  @url = Url.new
  erb :"urls/new"
end

# action: create
post '/urls' do
  # the new url's properties are namespaced under the top level params key
  # ':url'. This is because the Url input fields are named with a special
  # bracket notation, like so: <input name="url[full_url]"/>
  #
  # I'm using Url.new instead of Url.create because I want to branch
  # on whether saving the new Url was successful.
  @url = Url.new(params[:url])

  # here's where we check whether or not we successfully saved the new url
  if @url.save
    # if successful send the user back to urls#index
    redirect "/urls"
  else
    # If we couldn't save the new Url, something went wrong. So let's show
    # the new template (form) again. This way a user can fix any issues
    # and try and create a url again.
    #
    # Remember the template "/urls/new" makes use of an @url instance
    # variable to show any errors and pre-fills the form with the current
    # values for the Url the user is attempting to create
    erb :"/urls/new"
  end
end

# action: delete
delete '/urls/:id' do
  @url = Url.find(params[:id])
  @url.destroy

  redirect "/urls"
end

# action: ??
# This action is totally non-conventional. It's a vanity Url if there ever
# was one. It breaks convention for looks, which given the goal of this
# application, is just fine.
#
# This action needs to be listed last, since it uses a very greedy wildcard.
# The wildcard part is the ':short_code'
get '/:short_code' do
  if u = Url.find_by_short_code(params[:short_code])
    # right before we redirect to the full_url, increment the access count
    # we've added a method on the model for incrementing the count.
    u.increment_access_count
    redirect u.full_url
  else
    # If we couldn't find a Url in the db for the params[:short_code], send
    # back a simple error page. I've set the HTTP status code to the correct
    # '404'
    status 404
    "404 - Not found"
  end
end
