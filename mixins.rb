class String
  
    #
    # A hacky way of stripping down html to a little
    # snippet for display in lists and summaries.
    #
    def shortened_html(len = 100)
      stripped = self.gsub(/<\/?[^>]*>/, "")
      if stripped.length < len -3 
        stripped
      else
        stripped[0..(len-4)] + "..."
      end
    end
    
    #
    # convert to name with underscore and lower case
    #  "My Name".underscore # => "my_name"
    # 
    # as per ActiveSupport::CoreExtensions::String::Inflections
    #
    def underscore
      self.downcase.gsub(' ','_')
    end
    
    #
    # convert to name with spaces and capital 
    #  "my_name".humanize # => "My Name"
    # 
    # as per ActiveSupport::CoreExtensions::String::Inflections
    #
    def humanize 
      self.downcase.gsub('_',' ').split(' ').collect{|word| word.capitalize}.join(' ')
    end

end 