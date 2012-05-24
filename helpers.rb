
module NotesHelpers
  
  class HTMLwithHighlighting < Redcarpet::Render::HTML
    def block_code(code, language)
      if language 
      Pygments.highlight(code, :lexer => language)
    else
      code
    end
    end
  end
  
  #
  # Uses customized version (github) of markdown 
  # with syntax highlighting enabled 
  #
  def markdown2(text)
    options = {:hard_wrap => false, :filter_html => true, :autolink => true, :no_intraemphasis => true, :fenced_code_blocks => true, :gh_blockcode => true}
    Redcarpet::Markdown.new(HTMLwithHighlighting.new(:hard_wrap=>false),options).render(text)
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
    "<a href=\"/notes/#{params[:topic]}/#{params[:category]}\">#{params[:topic].humanize}, #{params[:category].humanize}</a>"
  end  
  
  # 
  # Loads the content in the given file. Returns a hash with the 
  # content. If there is a problem an empty hash is returned 
  #
  def load_content (file_name)
    results = Hash.new
    
    begin
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
    rescue Errno::ENOENT 
      # 
    end
    
    # parse 2 - now decode the content block 
    results.each do |k,v| 
      # title
      parsed_content = Hash.new
      parsed_content[:title] = v[0].strip
    
      parsed_content[:content] = ""
      parsed_content[:links] = []
      found_links = false
      
      v.shift
      v.each do |line|
        if line.start_with? (':links') 
          found_links = true
        elsif !found_links
            parsed_content[:content] << line  
        else
            parsed_content[:links] << line.strip if line.strip.length > 0        
        end
      end
      results[k] = parsed_content
    end  
    
  end
  
 
end