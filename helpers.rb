module NotesHelpers
  def foo(name) "#{name}foo" 
  end  
  def notes_link(params, key, title)
    "<a href=\"/notes/#{params[:topic]}/#{params[:category]}/#{key}\">#{title}</a>"
  end  
end