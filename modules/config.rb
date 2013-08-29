module NotesConfig
  
  def content_delivery_service_address
    config = YAML::load( File.open( ENV['HOME'] + '/.notes/dev/notes-website/config.yaml' ) )
    config ["content_delivery_service_address"]    
  end
  
  
end