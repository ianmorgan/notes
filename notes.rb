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

get '/notes/:topic/:category' do
  content = YAML::load_file ("content/#{params[:topic]}/#{params[:category]}.yml")
  erb :notes, :locals => { :content => content }
end

get '/notes/:topic/:category/:note' do
  content = YAML::load_file ("content/#{params[:topic]}/#{params[:category]}.yml")
  erb :note, :locals => { :content => content[params[:note]] }
end

#see http://koffeinfrei.heroku.com/2012/03/24/sinatra-with-bourbon
get '/assets/css/:name.css' do |name|
  require './views/scss/bourbon/lib/bourbon.rb'
  content_type :css
  scss "scss/#{name}".to_sym, :layout => false
end