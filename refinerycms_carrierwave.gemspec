# Encoding: UTF-8

Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms_carrierwave'
  s.version           = '1.0'
  s.description       = 'Allows RefineryCMS use carrierwave instead of dragonfly'
  s.date              = '2013-09-28'
  s.summary           = 'Override a few files so the images and resources use carrierwave and can be stored on Amazon S3'
  s.authors           = 'Ionut Alexandru Anca'
  s.require_paths     = %w(lib)
  s.files             = ["readme.md"] + Dir["{app,lib}/**/*"]

  # Runtime dependencies
  s.add_dependency             'refinerycms-core',    '~> 2.0'
  s.add_dependency             'fog'
  s.add_dependency             'mini_magick'
  s.add_dependency             'carrierwave'
    
end
