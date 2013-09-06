module NotesConfig
  
  def content_delivery_service_address
    location = ENV['HOME'] + '/.notes/' + ENV['RACK_ENV'] + '/services.yaml'
    config = YAML::load( File.open( location ) )
    config ['notes-content-delivery']['location']   
  end
  
  
end