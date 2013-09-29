refinerycms_carrierwave
=======================

This gem replaces dragonfly gem with carrierwave gem in RefineryCMS for better performance.
By using this gem the images and files uploaded in the backend of RefineryCMS will be served straight by Amazon S3 therefore offloading some processing from the server.


## Requirements

RefineryCMS 2.0 or later

## Install

```ruby
	gem 'refinerycms_carrierwave', :git => 'git@github.com:ionut998/refinerycms_carrierwave.git'
```

``bundle install``

add folowing to config/development.rb, config/production.rb

```ruby
	ENV['PROVIDER']='AWS'
	ENV['S3_KEY']='your-key'
	ENV['S3_SECRET']='your-secret-key'
	ENV['S3_BUCKET']='your-bucket-name'
```