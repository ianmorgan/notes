require 'redcarpet'
module NotesHelpers
  def foo(name) "#{name}foo" 
  end
  
  def markdown2(text)
    options = {:hard_wrap => true, :filter_html => true, :autolink => true, :no_intraemphasis => true, :fenced_code => true, :gh_blockcode => true}
    syntax_highlighter(Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(:hard_wrap=>true),options).render(text))
  end
  
  def syntax_highlighter(html)
    doc = Nokogiri::HTML(html)
    doc.search("//pre[@lang]").each do |pre|
      pre.replace Albino.colorize(pre.text.rstrip, pre[:lang])
    end
    doc.to_s
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