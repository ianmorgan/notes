require 'rubygems'
require 'sinatra'
require 'erb'
require 'yaml'
require 'redcarpet'
require 'pygments.rb'
require 'rubypython'

require File.join(File.dirname(__FILE__), 'helpers')
require File.join(File.dirname(__FILE__), 'mixins')

helpers NotesHelpers
RubyPython.start()

get '/' do
  topics = YAML::load_file('content/topics.yml')['topics']
  
  # convert to 2 D array 
  keys = topics.each_key.collect{|k|k}.sort
  grid_keys = []
  (0..keys.size-1).each do |index|
    if (index % 2 == 0)
      @row = []
      grid_keys.push @row
      @row[0] = keys[index]
    else
      @row[1] = keys[index]
    end
  end
  
  erb :index, :locals => {:grid_keys=> grid_keys , :topics => topics }
end

get '/about' do 
  erb :about
end

get '/layout.css' do 
  sass :layout 
end

get '/notes/:topic/:category' do
  content = load_content("content/#{params[:topic]}/#{params[:category]}.txt")
  if content.length > 0 
    erb :notes, :locals => { :content => content }
  else
    status 404
  end
end

get '/notes/:topic/:category/:note' do
  content = load_content("content/#{params[:topic]}/#{params[:category]}.txt")
  if content[params[:note].to_sym]
    erb :note, :locals => { :content => content[params[:note].to_sym] }
  else 
    status 404
  end
end

#see http://koffeinfrei.heroku.com/2012/03/24/sinatra-with-bourbon
get '/assets/css/:name.css' do |name|
  require './views/scss/bourbon/lib/bourbon.rb'
  content_type :css
  scss "scss/#{name}".to_sym, :layout => false
end


not_found do
  erb :notfound
end