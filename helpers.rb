module NotesHelpers
  def foo(name) "#{name}foo" 
  end
    
  #
  # Builds a link to a given note
  #
  def notes_link(params, key, title)
    "<a href=\"/notes/#{params[:topic]}/#{params[:category]}/#{key}\">#{title}</a>"
  end  

  #
  # Builds a link to a given topic and category
  #
  def category_link(params)
    "<a href=\"/notes/#{params[:topic]}/#{params[:category]}\">#{params[:topic].capitalize} #{params[:category].capitalize}</a>"
  end  
  
  
  def load_content (file_name)
    results = Hash.new
    file = File.new(file_name, "r")
    
    # parse 1 - break out into keys and raw content blocks
    while (line = file.gets)
      if line.start_with?('::')
        content = []
        results[line.sub('::','').strip.to_sym] = content
      else 
        content << line
      end
    end
    
    # parse 2 - now decode the content block 
    results.each do |k,v| 
      parsed_content = Hash.new
      parsed_content[:title] = v[0].strip
      v.shift
      parsed_content[:content] = v.join('')
      results[k] = parsed_content
    end  
    
  end
  
 
end