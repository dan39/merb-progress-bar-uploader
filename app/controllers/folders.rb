class Folders < Application
  # provides :xml, :yaml, :js
#before :login_required, :only => [ :show ]
#before :stop_access, :with => 'admin'



#before :bitemeseeinto, :except => :index 
 
# before :role_required, :with => 'Admin'

#before :is_admin?


  def xxxxbitemeseeinto
    unless is_admin == "Admin"
      redirect url(:pockies)
      false
    end
  end
     def xxxxxacurrent_user
        @current_user ||= (login_from_session || login_from_basic_auth || login_from_cookie || false)
      end
      
  def stop_access(role)
    p "craaaap"
    p current_user
    rolescheck = has_role?(role)
      #throw(:halt, :not_authorized) unless rolescheck
       redirect url(:pockies) unless rolescheck
#       throw(:halt, :not_authorized) 
      #redirect url(:pockies)
      
  end
  
   
  
  def has_role?(role)
    current_user.has_role?(role)
  end
  
   
    def role_required?(role)
      throw(:halt, :not_authorized) unless has_role?(role)
      
    end
  
  def xxxxcan_edit?
    get_user_id = session[:user].to_i
    params[:fish] = get_user_id
    current_user.can_edit? << params[:fish]
    #user = User.find(session[:user].to_i)
    
  end

  def xxxxhas_bunny?(role)
     role.to_s = "admin"
  end
  
  def is_admin
    @idtagnumber = session[:user]
 #   user = User.find(1)
    p "cccccccrrrraaaappppp"
    p session[:user].to_i
 #   puts foo
   user = User.find(session[:user].to_i)
    user.roles[0].name
    # current_user.is_admin
   end 
 
 
  
   def xxxxxacurrent_user
     @current_user = "admin"
   end
 
   # Store the given user in the session.
   def xxxxxacurrent_user=(new_user)
     session[:user] = (!new_user || !new_user.kind_of?(User)) ? nil : new_user.id
     @current_user = new_user
   end


# =>          
# =>           def admin?
# =>             self.current_user = User.find_with_conditions(:id => session[:user]) if session[:user]
# =>             p "ultra crap"
# =>             puts self.current_user.roles
   # so I have a 1 but now I need that 1 to = Admin ehto....
#    a.roles.find(1)
#   => #<Role id: 1, name: "Admin">
#   >> b = a.roles.find(1)
#   => #<Role id: 1, name: "Admin">
#   >> b.type
#   (irb):19: warning: Object#type is deprecated; use Object#class
#   => Role(id: integer, name: string)
#   >> b.name
#   => "Admin"
#   >> a.roles[0]
#   => #<Role id: 1, name: "Admin">
#   >> a.roles[0].name
#   => "Admin"
#   >> 
   
#   self.current_user.roles == "Admin"
  #true
# =>           end
 
 
 
   #has roles fun from shay 
       
 
 
 
 
 
 
 
 
 
 
 
 
  def index
   # @folders = Folder.find(:all)
#    display @folders
      redirect url(:folder, 1)
  end

  def show
    p "crap"
    p session.inspect
   # @basefiles = Folder.find_by_id(params[:id]).basefiles
    @file_list = Dir.new("#{Merb.root}/public/uploads/")     
    
 @folder = Folder.find_by_id(params[:id])
 @root_folders = Folder.find_all_by_parent_id(1)
 
 
 @basefiles = @folder.basefiles
   # @folder = Folder.find(params[:id])
    @filess = @folder.basefiles.build
    @ffff = @folder.basefiles
    
    @find_the_other_folders = @folder.children
    
    
    
      @find_the_other_folders2 = @folder
    raise NotFound unless @folder
    display @folder
  end

  def new
    only_provides :html
    @folder = Folder.new(params[:folder])

       
 #   @folder.create(params[:folder])
    render
  end


 
  def create
#    @folder = Folder.new(params[:folder])
 @folder = Folder.find_by_id(params[:folder_id])
     @folder.parent_id = params[:id]
     if @folder.save
       redirect url(:folder, @folder)
      else
        render :action => :new
      end
      # @folder.children.create(params[:folder])
       
  # @folder = Folder.find_by_id(params[:folder])
  
  #           @folder.children.create(params[:folder])
             
 #    if @folder.save

   #  end
#    @folder.children.create(params[:folder, folder_id])
#        @find_the_other_folders = Folder.find(@folder.folder_id)
#    @folder.children.create(params[:folder])      
#    if @folder.save
 #     redirect url(:folder, @folder)
  #  else
   #   render :action => :new
  #  end
  end

  def edit
    only_provides :html
    @folder_edit_now = Folder.find_by_id(params[:id])
     #@find_the_other_folders = @folder.child
    raise NotFound unless @folder_edit_now
    render
  end

 
  def update
    @folder = Folder.find_by_id(params[:id])
 #   @folder = Folder.find_by_id(params[:id])
    
#    @folder = Folder.find_by_id(params[:id])
    raise NotFound unless @folder 
 #  @folder_edit_now.children.create(params[:folder])
      @folder.update_attributes(params[:folder])
    #@folder.children.create(params[:folder])
#    if @folder.update_attributes(params[:folder])
      redirect url(:folder, @folder)
 #   else
  #    raise BadRequest
   # end
  end
  
    def create_sub_folder
      @folder_edit_now = Folder.find_by_id(params[:id_digital_numbers])
              #   @folder = Folder.find_by_id(params[:id])

                  #    @folder = Folder.find_by_id(params[:id])
      raise NotFound unless @folder_edit_now 
     @folder_edit_now.children.create(params[:folder])
                    #    @folder_edit_now.update_attributes(params[:folder])
                              #folder.children.create(params[:folder])
                                        #    if @folder.update_attributes(params[:folder])
        redirect url(:folder, @folder_edit_now)
                    #   else
                            #    raise BadRequest
                                  #end
    end
    

  def destroy

    @folder = Folder.find_by_id(params[:id])
    @folder_send_to = @folder.parent_id
        @basefile = @folder.basefiles.find_by_id(params[:id])
    raise NotFound unless @folder || @basefile
       
    if @folder.destroy
      redirect url(:folder, @folder_send_to)
    elsif @basefiles.destory
      redirect url(:folders)
    else
      raise BadRequest
    end
    
  end
  
  
  
#####  #has roles fun from shay 
#####        def is_admin?
#####          logged_in? && current_user.is_admin?
#####        end
#####
#####        def has_role?(role)
#####          logged_in? && current_user.has_role?(role)
#####        end
#####
#####        def role_required(role)
#####          throw(:halt, :not_authorized) unless has_role?(role)
#####        end
#####
#####        def admin_required
#####          throw(:halt, :not_admin) unless is_admin?
#####        end
#####
#####        def not_authorized
#####          case content_type
#####          when :html
#####        #    flash[:notice] = "You do not have access to that page."
#####            redirect('/')
#####          when :xml
#####            headers["Status"]             = "Unauthorized"
#####            headers["WWW-Authenticate"]   = %(Basic realm="Web Password")
#####            set_status(401)
#####            render :text => "Couldn't authenticate you"
#####          end
#####        end
#####
#####        def not_admin
#####          case content_type
#####          when :html
#####            return "<h2>You are not an administrator</h2><p>#{link_to 'Back', '/'}</p>"
#####          when :xml
#####            headers["Status"]             = "Unauthorized"
#####            headers["WWW-Authenticate"]   = %(Basic realm="Web Password")
#####            set_status(401)
#####            render "Couldn't authenticate you", :status => 401
#####          end
#####        end
  
       def get_files
     #    p :filename
         p "tacos"
         p params[:filename]
         p "poooo"
#         p url(:doggy)
#        @file =  "#{Merb.root}/public/uploads/#{params[:filename]}"
@file = "/fake/#{params[:filename]}"
          # filename = "#{Merb.root}/public/uploads/readme.txt" 
          p "not a filllle"
          p @file
			     headers['Content-Type'] = "application/force-download" 
			     #headers['Content-Disposition'] = "attachment; filename=\"#{File.basename(filename)}\"" 
			     #headers["X-Sendfile"] = @file
			     #headers['Content-length'] = File.size(filename)
           headers['Content-Disposition'] = "attachment; filename = '#{params[:filename]}'"   
        
        @filename = @file.to_s
        p @filename
        
        
      				#headers['Content-Disposition'] = "attachment; filename = #{params[:filename]}"  
			          #headers['Content-Type'] ="#{get_the_file_content_type}"  
         			 #Content-Disposition: attachment; filename=genome.jpeg;
          
            #nginx_send_file( "/protected" / "path/to/file" )
            
        nginx_send_file("/fake/24c00ad3317f13d963376602287b3c6a.jpg")
#        send_file(@file)
        
         
       end
       
       
       def nginx_working_on
            #    p :filename
                p "tacos"
                p params[:filename]
                p "poooo"
       #         p url(:doggy)
               @file =  "#{Merb.root}/public/uploads/#{params[:filename]}"
                 # filename = "#{Merb.root}/public/uploads/readme.txt" 
                 p "not a filllle"
                 p @file
                # headers['Content-Type'] = "application/force-download" 
               #  headers['Content-Disposition'] = "attachment; filename=\"#{File.basename(filename)}\"" 
                #headers["X-Sendfile"] = @file
               #  headers['Content-length'] = File.size(filename)
               @filename = @file.to_s
               p @filename
       #      nginx_send_file( "/protected" / "path/to/file" ) 
       #headers['Content-Disposition'] = "attachment; filename = #{File.basename(background_logo.gif)}"  
               headers['Content-Disposition'] = "attachment; filename = 'tile_bg7.gif'"  
             headers['Content-Type'] ="application/force-download"  
               nginx_send_file("/fakehxthxt"/@file)
               #send_file(@file)
       end
       
       
       
       
       
       
       def crapola
        p "etueuinuetin"
       end
       def get_readme
        # filename = "#{Merb.root}/public/uploads/readme.txt" 
         
      #  headers['Content-Type'] = "application/force-download" 
      #  headers['Content-Disposition'] = "attachment; filename=\"#{File.basename(filename)}\"" 
      #  headers["X-Sendfile"] = filename
      #  headers['Content-length'] = File.size(filename)
    #  stupid = #{get_readme}
      p "water"
      p params
       render :text => "fish"
     # p "#{get_readme}"
      #p filename
           #send_file("#{Merb.root}/public/uploads/readme.txt", :filename => 'yo_readme.txt')
         #  send_file(stupid)
           
         end

          
end
