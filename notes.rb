require 'sinatra'
require 'erb'
require 'yaml'
require 'bluecloth'
require_relative 'helpers'

helpers NotesHelpers

get '/' do
  topics = YAML::load_file('content/topics.yml')['topics']
  erb :index, :locals => {:topics => topics }
end

get '/hi' do 
  'hello world'
end

get '/layout.css' do 
  sass :layout 
end

get '/notes/:topic/:category' do
  content = load_content("content/#{params[:topic]}/#{params[:category]}.txt")
  erb :notes, :locals => { :content => content }
end

get '/notes/:topic/:category/:note' do
  content = load_content("content/#{params[:topic]}/#{params[:category]}.txt")
  erb :note, :locals => { :content => content[params[:note].to_sym] }
end

#see http://koffeinfrei.heroku.com/2012/03/24/sinatra-with-bourbon
get '/assets/css/:name.css' do |name|
  require './views/scss/bourbon/lib/bourbon.rb'
  content_type :css
  scss "scss/#{name}".to_sym, :layout => false
end