require 'sinatra'
require 'erb'
require 'yaml'

get '/' do
  erb :index
end

get '/hi' do 
  'hello world'
end

get '/notes/:topic' do
  
  content = YAML::load_file ("content/#{params[:topic]}.yml")
  erb :notes, :locals => { :content => content }

end