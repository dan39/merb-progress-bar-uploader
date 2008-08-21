require "fileutils"
#require "image_science"

class Basefile < ActiveRecord::Base
  
   belongs_to :folder
  ### Note this (validates_uniqueness_of) just now needs basefiles and 
  ## The flash javascript notice
  ## Cause right now it's not parsing to find out the data. Like it needs to kick back BEFORE the upload it's pressed
  #### Stupid idea, what if the upload just polled the current page for the title ? 

  ##### A time re namer for later 
  ###   Needs a grep remamer to retain the .zip file or whaterever

  ###### =>         a = Time.now
  ###### =>         a.strftime("%b:%M%p")  
  ###### =>         
  ###### =>         Neat:
  ###### =>         a.strftime("%b:%I:%M")
  ###### =>         
  ###### =>         a.strftime("%a_%b:%I:%M_%p").downcase

  #
  #
  #
  #
  #
  #

     validates_uniqueness_of :filename #, :scope => 'basefile_id'

    attr_accessor :filetemp
    attr_accessor :filetempname
  #debugger    
  

    def self.from(tempfile)

  puts tempfile.inspect    
      # tempfile is post[:image] from the controller above ^^
      basefile = Basefile.new do |i|

        i.content_type = tempfile[:content_type]
        i.filename     = tempfile[:filename]
  #i.filename.gsub(/[^\w\.\-]/, '_') 
        i.size         = tempfile[:size]
        i.folder_id = tempfile[:folder_id]
        p "bite me"
        p i.folder_id
        p i.size
       
      end
 #  basefile.folder_id         = tempfile[:folder_id]
      basefile.filetemp = tempfile[:tempfile]
      basefile.filetempname = tempfile[:filename]


      name = basefile.filetempname.gsub(/^.*(\\|\/)/, '')
      basefile.filetempname = name.gsub(/[^\w\.\-]/, '_') 
      basefile.filename =         basefile.filename.gsub(/[^\w\.\-]/, '_') 
              
      #basefile.filename = basefile.filetempname
      
      
      return basefile
    end

    def basefile_path
      
      #File.join( Merb.root, "/uploads/#{ self.id }" )
         #File.join( Merb.root, "/uploads/#{ self.id }" )
                File.join( Merb.root, "/public/uploads/#{filetempname}" )
  #              UPLOAD_PATH = "#{RAILS_ROOT}/public/uploads"
      #Merb.root/'uploads'/params[:file][:filename]
    end


    def before_create
      # Now move the original temporary file from it's home
      # in /tmp to whatever our upload directory is
      p "omg!!!"
      p filetemp.path
      FileUtils.mv( filetemp.path, basefile_path )
      #FileUtils.mv( filetemp.path, basefile_path )

      #FileUtils.mv params[:file][:tempfile].path, Merb.root/'uploads'/params[:file][:filename]

    end

    def destroy
      # Make sure we kill both the model and the file on disk
      begin
        @basefile_file = Merb.root, "/public/uploads/"
        File.delete "#{@basefile_file}" + self.filename #if File.exist?( "#{@basefile_file}" + self.filename )
      ensure
        super
      end
    end


#




  #  def file=(file_data)
  #    return nil if file_data.nil? || file_data['size'] == 0
  #    self.content_type = file_data['content_type']
  #    self.filename     = file_data['filename'] if respond_to?(:filename)
  #    self.size         = file_data['size']
  #    @file = file_data['tempfile']
  #    FileUtils.mv @file.path, Merb.root/'uploads'/#{self.filename}"
  #    
  #  end

  # AAS OOf feb 12 this worked not rally though just close to itish
  # def title=(file) 
  #
  ##self.content_type = picture_field.content_type.chomp 
  ##self.data = picture_field.read 
  # puts params[:file].inspect
  #self.file = [:filename]
  #self. 
  #   #FileUtils.mv params[:file][:tempfile].path, MERB_ROOT+"/uploads/#{params[:file][:filename]}"
  #   FileUtils.mv params[:file][:tempfile].path, Merb.root/'uploads'/params[:file][:filename]
  #
  # end 
  #
  # def base_part_of(file_name) 
  # File.basename(file_name).gsub(/[^\w._-]/, '') 
  # end 
  #
  #
  #
  #after_create :move_tempfile
  #
  # def title=(file_data)
  #   return nil if file_data.nil? || file_data['size'] == 0
  #   self.content_type = file_data['content_type']
  #   self.filename     = file_data['filename'] if respond_to?(:filename)
  #   self.size         = file_data['size']
  #   @file = file_data['tempfile']
  # end
  # 
  # def full_filename
  #   Merb.root + "/uploads/#{self.id}/#{self.filename}"
  # end
  # 
  # protected
  # def move_tempfile
  #   FileUtils.mkdir_p Merb.root + "/uploads/#{self.id}"
  #   FileUtils.mv @file.path, Merb.root + "/uploads/#{id}/#{self.filename}"
  # end
  #
 
    
end