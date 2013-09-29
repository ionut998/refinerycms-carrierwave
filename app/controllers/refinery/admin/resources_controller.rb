module Refinery
  module Admin
    class ResourcesController < ::Refinery::AdminController

      crudify :'refinery/resource',
        :order => "updated_at DESC",
        :xhr_paging => true

      before_filter :init_dialog
            
      def index
        
        @resources = ::Refinery::Resource.order()
          
        @sort_field = params[:sort_field] || 'refinery_resources.created_at'
        @sort_field = ::Refinery::Resource.column_names.include?(@sort_field[20..@sort_field.length]) ? @sort_field : 'refinery_resources.created_at'
        @sort_dir = params[:sort_dir] == 'desc' ? 'desc' : 'asc'
          
        @resources = @resources.order(@sort_field+' '+@sort_dir)
        @resources = @resources.page(params[:page])
        
      end

      def new
        @resource = Resource.new if @resource.nil?

        @url_override = refinery.admin_resources_path(:dialog => from_dialog?)
      end

      def create
        @resources = []
        
        unless params[:resource].present? and params[:resource][:file_name].is_a?(Array)
          @resource = ::Refinery::Resource.create(params[:resource])
          @resources << @resource
        else
          params[:resource][:file_name].each do |resource|
            @resources << (@resource = ::Refinery::Resource.create(:file_name => resource))
          end
        end

        unless params[:insert]
          if @resources.all?(&:valid?)
            flash.notice = t('created', :scope => 'refinery.crudify', :what => "'#{@resources.map(&:title).join("', '")}'")
            if from_dialog?
              #@dialog_successful = true
              #render :nothing => true, :layout => true
              #to be revised 
              render :text => '<script>parent.window.location.href = parent.window.location.href;</script>'
            else
              redirect_to refinery.admin_resources_path
            end
          else
            self.new # important for dialogs
            render :action => 'new'
          end
        else
          # if all uploaded files are ok redirect page back to dialog, else show current page with error
          if @resources.all?(&:valid?)
            @resource_id = @resource.id if @resource.persisted?
            @resource = nil

            self.insert
          end
        end
        
        
      end

      def insert
        self.new if @resource.nil?

        @url_override = refinery.admin_resources_path(request.query_parameters.merge(:insert => true))

        if params[:conditions].present?
          extra_condition = params[:conditions].split(',')

          extra_condition[1] = true if extra_condition[1] == "true"
          extra_condition[1] = false if extra_condition[1] == "false"
          extra_condition[1] = nil if extra_condition[1] == "nil"
          paginate_resources({extra_condition[0].to_sym => extra_condition[1]})
        else
          paginate_resources
        end
        render :action => "insert"
      end

      protected

      def init_dialog
        @app_dialog = params[:app_dialog].present?
        @field = params[:field]
        @update_resource = params[:update_resource]
        @update_text = params[:update_text]
        @thumbnail = params[:thumbnail]
        @callback = params[:callback]
        @conditions = params[:conditions]
        @current_link = params[:current_link]
      end

      def restrict_controller
        super unless action_name == 'insert'
      end

      def paginate_resources(conditions={})
        @resources = Resource.where(conditions).
          paginate(:page => params[:page], :per_page => Resource.per_page(from_dialog?)).
          order('created_at DESC')
      end

    end
  end
end
