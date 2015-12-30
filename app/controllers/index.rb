get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/urls' do
  @url = params[:input_url]
  Url.create(url: @url )
  @short_url = Url.last.short_url
  erb :index
end

# e.g., /q6bda
get '/:short_url' do
  # redirect to appropriate "long" URL
  @short_url = params[:short_url]
  full_url = Url.where(short_url: @short_url).pluck(:url)
  # full_url[0]
  redirect full_url[0]
end



# localhos9393/hello/?x=5

# get '/hello' do
#   @welcome = Url.first
#  "Hello from user #{params[:x]}"
#  erb :index
#  redirect "/url?welcome=#{@welcome}" <-query parameter passing info
# end


# get '/url' do
#    params[:welcome]
# end

