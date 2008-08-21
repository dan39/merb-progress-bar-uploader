module Merb
  module GlobalHelpers
    # helpers defined here available to all views.  
      def path(folder, link_to_self)
        # the base url for a path is always the same:
        url = url(:folders)
      
        # start with the deepest folder and work your way up
        if link_to_self
          path = folder.title
          id = folder.id.to_s
      
          # get the folders until folder doesn't have a parent anymore
          # (you're working your way up now)
          until folder.parent == nil
            folder = folder.parent
            path = folder.title + "/" + path
          end
      
          # Finally, make it a link...
          path = '<a href="' + url + '/' + id + '">' + h(path) + '</a>'
        else
          path = h(folder.title)
      
          # get the folders until folder doesn't have a parent anymore
          # (you're working your way up now)
          until folder.parent == nil
            folder = folder.parent
            path = '<a href="' + url + '/' + folder.id.to_s + '">' + h(folder.title) + '</a> &#187; ' + path
          end
        end
      
        return path
      end
  end
  
 
end
