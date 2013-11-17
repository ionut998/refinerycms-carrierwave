Refinerycms Carrierwave
=======================

This gem replaces dragonfly gem with carrierwave gem in RefineryCMS for better performance.
By using this gem the images and files uploaded in the backend of RefineryCMS will be served straight by Amazon S3 therefore offloading some processing from the server.


## Requirements

RefineryCMS 2.0 or later

## Installation

add the following line to the bottom of your Gemfile :

```ruby
 gem 'refinerycms-carrierwave', :git => 'git@github.com:ionut998/refinerycms-carrierwave.git'
```

run :

``bundle install``

add folowing to config/environments/development.rb and config/environments/production.rb: 

```ruby
 ENV['PROVIDER']='AWS'
 ENV['S3_KEY']='your-key'
 ENV['S3_SECRET']='your-secret-key'
 ENV['S3_BUCKET']='your-bucket-name'
```


## 
author: Ionut Alexandru Anca
