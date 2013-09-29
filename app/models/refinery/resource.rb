module Refinery
  class Resource < Refinery::Core::BaseModel

    attr_accessible :id, :file_name, :file_size
    
    before_save :update_file_attributes
    
    mount_uploader :file_name, FileUploader

    validates :file_name, :presence => true

    # used for searching
    def type_of_content
      self.file_mime_type.split("/").join(" ")
    end
    
    def ext
      return self.file_ext
    end
    
    def size
      return self.file_size
    end
    
    def url
      return self.file_name_url
    end

    # Returns a titleized version of the filename
    # my_file.pdf returns My File
    def title
      #CGI::unescape(file_name.to_s).gsub(/\.\w+$/, '').titleize
      self[:file_name].gsub(/\.\w+$/, '').titleize rescue ''
    end
    
    

    class << self
      # How many resources per page should be displayed?
      def per_page(dialog = false)
        dialog ? Resources.pages_per_dialog : Resources.pages_per_admin_index
      end
    end
    
    private
    
      def update_file_attributes
        if file_name.present?
          self.file_mime_type = file_name.file.content_type
          self.file_size = file_name.file.size
          self.file_ext = self.file_mime_type.split("/").last rescue ''
          #self.file_width, self.file_height = `identify -format "%wx%h" #{file_name.file.path}`.split(/x/)
          # if you also need to store the original filename:
          # self.original_filename = image.file.filename
        end
      end
    
    
  end
end
