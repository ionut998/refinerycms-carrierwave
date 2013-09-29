module Refinery
  class Image < Refinery::Core::BaseModel
  
    before_save :update_image_attributes

    mount_uploader :image_name, ImageUploader

    validates :image_name, :presence  => true
       
    # Docs for acts_as_indexed http://github.com/dougal/acts_as_indexed
    acts_as_indexed :fields => [:title]

    # allows Mass-Assignment
    attr_accessible :id, :image_name, :image_size

    
    class << self
      # How many images per page should be displayed?
      def per_page(dialog = false, has_size_options = false)
        if dialog
          unless has_size_options
            Images.pages_per_dialog
          else
            Images.pages_per_dialog_that_have_size_options
          end
        else
          Images.pages_per_admin_index
        end
      end
    end


    # Returns a titleized version of the filename
    # my_file.jpg returns My File
    def title
      #CGI::unescape(image_name.to_s).gsub(/\.\w+$/, '').titleize
      self[:image_name].gsub(/\.\w+$/, '').titleize rescue ''
    end

    def url
      return self.image_name_url(:small)
    end
    
    private
    
    def update_image_attributes
      if image_name.present?
        self.image_mime_type = image_name.file.content_type
        self.image_size = image_name.file.size
        self.image_width, self.image_height = `identify -format "%wx%h" #{image_name.file.path}`.split(/x/)
        # if you also need to store the original filename:
        # self.original_filename = image.file.filename
      end
    end

  end
end
