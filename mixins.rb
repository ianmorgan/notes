class String
  
    #
    # A hacky way of stripping down html to a little
    # snippet for display in lists and summaries.
    #
    def shortened_html(len = 100)
      stripped = self.gsub(/<\/?[^>]*>/, "")
      if stripped.length < len -4 
        stripped
      else
        stripped[0..(len-4)] + "..."
      end
    end

end 