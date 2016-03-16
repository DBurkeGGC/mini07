require 'sinatra'
require 'uri'
require 'active_record'

db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///mycustomers')

ActiveRecord::Base.establish_connection(
  :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  :host     => db.host,
  :username => db.user,
  :password => db.password,
  :database => db.path[1..-1],
  :encoding => 'utf8'
)

class Customer < ActiveRecord::Base
end

get '/' do
  erb :index
end

get '/list' do
  @links = Customer.order("id DESC")
  erb :list
end

get '/create' do
  erb :create
end

get '/destroy' do
  Customer.delete_all
  redirect to "/"
end

post '/create' do
  link = Customer.new(params[:link])
  if link.save
    redirect to "/list"
  else
    return "failure!"
  end
end
