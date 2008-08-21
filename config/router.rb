# Merb::Router is the request routing mapper for the merb framework.
#
# You can route a specific URL to a controller / action pair:
#
#   r.match("/contact").
#     to(:controller => "info", :action => "contact")
#
# You can define placeholder parts of the url with the :symbol notation. These
# placeholders will be available in the params hash of your controllers. For example:
#
#   r.match("/books/:book_id/:action").
#     to(:controller => "books")
#   
# Or, use placeholders in the "to" results for more complicated routing, e.g.:
#
#   r.match("/admin/:module/:controller/:action/:id").
#     to(:controller => ":module/:controller")
#
# You can also use regular expressions, deferred routes, and many other options.
# See merb/specs/merb/router.rb for a fairly complete usage sample.

Merb.logger.info("Compiling routes...")
Merb::Router.prepare do |r|
    # RESTful routes

r.add_slice(:MerbAuth, :path => "", :default_routes => false) 


   r.match("/folders/get_readme").to(:controller => "folders", :action => "get_readme").name(:get_readme)
  #  r.match("/crapola/:filename.to_s").to(:controller => 'folders', :action => 'get_files')
    r.match(%r[^/crapola/(.+)], :method => :get).to(:controller => 'folders', :filename => "[1]", :action => 'get_files').name(:doggy)
  #  r.match("/folders/create_sub_folder").to(:controller => "folders", :action => "create_sub_folder").name(:create_sub_folder)
    r.match(%r[^/create_sub_folder/(.+)], 
    :method => :post).to(:controller => 'folders', :id_digital_numbers => "[1]", 
    :action => 'create_sub_folder').name(:create_sub_folder)


    r.resources :pockies  
    # r.resources :posts
    r.resources :folders



    #r.resources :basefiles
  #  r.resources :bunnies
    r.resources :folders do |basefiles|
      basefiles.resources :basefiles
    end




   r.match("/swfupload").to(:controller => "basefiles", :action => "swfupload").name(:swfupload)
   r.match("/nuke_this/@folder.id/basefiles/b.id").to(:controller => "basefiles", :action => "delete").name(:delete)
  # r.match("/folders/:id/new").to(:controller => "folders", :action => "update").name(:update)

  #r.match('/folders/:id/basefiles/:id/destroy').to(:controller => 'Basefiles', :action => 'destroy').name(:eatme)

    #r.match('/').to(:controller => 'basefiles', :action => 'index')

    #r.match('/basefiles').to(:controller => 'basefiles', :action => 'index')

    #this one seems to do squart now
     r.match("/create_basefile").to(:controller => "basefiles", :action => "create_basefile").name(:create_basefile)


    # This is the default route for /:controller/:action/:id
    # This is fine for most cases.  If you're heavily using resource-based
    # routes, you may want to comment/remove this line to prevent
    # clients from calling your create or destroy actions with a GET


  # r.default_routes

    # Change this for your home page to be available at /
    # r.match('/').to(:controller => 'whatever', :action =>'index')
    
end