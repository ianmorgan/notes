require 'sinatra'
require 'erb'
require 'yaml'
require_relative 'helpers'

helpers NotesHelpers

get '/' do
  erb :index
end

get '/hi' do 
  'hello world'
end

get '/layout.css' do 
  sass :layout 
end

get '/notes/:topic' do
  
  content = YAML::load_file ("content/#{params[:topic]}.yml")
  erb :notes, :locals => { :content => content }

end

#see http://koffeinfrei.heroku.com/2012/03/24/sinatra-with-bourbon
get '/assets/css/:name.css' do |name|
  require './views/scss/bourbon/lib/bourbon.rb'
  content_type :css
  scss "scss/#{name}".to_sym, :layout => false
end