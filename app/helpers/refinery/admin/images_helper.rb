module Refinery
  module Admin
    module ImagesHelper
      def other_image_views
        Refinery::Images.image_views.reject { |image_view|
          image_view.to_s == Refinery::Images.preferred_image_view.to_s
        }
      end

      def thumbnail_urls(image)
        thumbnail_urls = {
          :"data-original" => image.image_name.url,
          :"data-grid" => image.image_name.url
        }
         
        Refinery::Images.user_image_sizes.each_key do |key|
          thumbnail_urls[:"data-#{key}"] = image.image_name.url(key)
        end

        thumbnail_urls
      end
    end
  end
end
