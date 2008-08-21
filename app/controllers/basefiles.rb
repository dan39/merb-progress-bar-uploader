class Basefiles < Application
  
#   before :login_required, :only => [ :show ]
   
   
   provides :xml, :yaml, :js
  
  def index

    @basefiles = Basefile.find(:all)

    @file_list = Dir.new("#{Merb.root}/public/uploads/")     
   display @basefiles
  # render
  end
  
 
  def show
    @basefile = Basefile.find_by_id(params[:id])
    raise NotFound unless @basefile
    display @basefile
  end

  def new
  
     @file_list = Dir.new("#{Merb.root}/public/uploads/")     
  #  @basefile = Basefile.new(params[:basefile])
    render
  end

  def create
  
        # The content_type is set as application/octet by the flash program
        # Use mimetype-fu to determine the mimetype before passing it 
        # to the attachment_fu enabled model
        # @basefile.save!
        # redirect( url(:folder,@basefile.folder_id) )

         p "CRUUUUURD aarrrrrgg"
    p params 
        p "is this it now?"

        p "anything?"

         p params[:Filedata]
         @basefile = Basefile.from(params[:Filedata].merge(:folder_id => params[:folder_id]))
         @folder = Folder.find(@basefile.folder_id)

    #    @basefile = Basefile.from(params[:Filedata])
        #Basefile.from(params[:butt]) 

    #    params[:Filedata].content_type = File.mime_type?(params[:Filedata].original_filename)
     #   @basefile = Basefile.from(params[:butt] => params[:Filedata])

    #         @basefile.folder_id = $taco
              p "CRUUUUURD"
             p params[:folder_id]
    #             @basenumber = @basefile.folder_id
        @basefile.save!
   #    redirect( "folders/"+"#{@basenumber}" )
       redirect url(:folder, @folder)
       
           # redirect_to :controller => 'folders', :id => params[:id]

        # This returns the thumbnail url for handlers.js to use to display the thumbnail
    #  rescue
     #   render :text => "Error"
  end

  def edit
    only_provides :html
    @basefile = Basefile.find_by_id(params[:id])
    raise NotFound unless @basefile
    render
  end


  def update
    @basefile = Basefile.find_by_id(params[:id])
    raise NotFound unless @basefile
    if @basefile.update_attributes(params[:basefile])
      redirect url(:basefile, @basefile)
    else
      raise BadRequest
    end
  end

  def destroy
     #@folder = Folder.find_by_id(params[:id])
#          @basefile = @folder.basefiles.find_by_id(params[:id])
          @basefiles = Basefile.find_by_id(params[:id])
          @basenumber =       @basefiles.folder_id
          puts  @basenumber 
      raise NotFound unless @basefiles
            
      if @basefiles.destroy
#        redirect url(:folders)
         
        redirect( "/folders/"+"#{@basenumber}" )
        
      else
        raise BadRequest
      end

    end

  
  def create_basefile

    #case request.method
   # when :get
   @basefile = Basefile.from(params[:butt]) 

   # when :post
      # post will be post[image] in the form
#      @basefile = Basefile.from(params[:butt])
      # save! will call before_create in our image model
      # at which point we move the upload from /tmp to it's new home
      @basefile.save!
    #end

     redirect url(:basefiles)
  end
  
  
  ######### Uploader Progress From Fancyupload and some hacking from swfupload
  
  def swfupload
    # swfupload action set in routes.rb
    
    # The content_type is set as application/octet by the flash program
    # Use mimetype-fu to determine the mimetype before passing it 
    # to the attachment_fu enabled model
    # @basefile.save!
    # redirect( url(:folder,@basefile.folder_id) )
     
     p "CRUUUUURD aarrrrrgg"
p params 
    p "is this it now?"
    
    p $taco
    p "anything?"
    
     p params[:Filedata]
     @basefile = Basefile.from(params[:Filedata].merge(:folder_id => params[:folder_id]))

#    @basefile = Basefile.from(params[:Filedata])
    #Basefile.from(params[:butt]) 
    
#    params[:Filedata].content_type = File.mime_type?(params[:Filedata].original_filename)
 #   @basefile = Basefile.from(params[:butt] => params[:Filedata])

#         @basefile.folder_id = $taco
          p "CRUUUUURD"
         p params[:folder_id]
#             @basenumber = @basefile.folder_id
    @basefile.save!
   redirect( "folders/"+"#{@basenumber}" )
       # redirect_to :controller => 'folders', :id => params[:id]
    
    # This returns the thumbnail url for handlers.js to use to display the thumbnail
#  rescue
 #   render :text => "Error"
  end
  
   
  ######### Uploader Progress bar from Old site 
  ######### Uploader Progress bar from Old site 
  ######### Uploader Progress bar from Old site 
  ######### Uploader Progress bar from Old site 
  ######### Uploader Progress bar from Old site 

### It neeeds lots of files, A few java script files, .... note find these
###### As well as the conf file to start it and then the drb to run it better 
#### Funny though the Model seems to Just upload the file to the server and the database and thats it ......
  
  # Shows upload progress.
  # For details, see http://mongrel.rubyforge.org/docs/upload_progress.html
#######################
#######################
############################################################################################
#######################
#######################
##############################################
  
  
  
  
  
  
  
  
  
  
  ###### Depriciated controller example
  def upload
          puts params[:file].inspect
          #FileUtils.mv params[:file][:tempfile].path, MERB_ROOT+"/uploads/#{params[:file][:filename]}"
          FileUtils.mv params[:file][:tempfile].path, Merb.root/'public/uploads'/params[:file][:filename]
    redirect url(:basefiles)
  end
  
  
  
end
