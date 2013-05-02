require "sprockets"
require "sprockets-sass"
require "sprockets-helpers"
require "sass"
require "index_builder.rb"

activate :jc_index_builder, {
  :include_prototypes => 'yes', # 'yes', 'no', 'only'
  :prototypes_dir => 'prototypes/',
  :group_directories => true,
  :sitemap_partial => 'partials/_render_sitemap.html.haml',
  :exclude_directories => [] # Pass an array of strings, ie. ['prototypes', 'documentation']
}

activate :sprockets

#Livereload
activate :livereload

set :relative_links, true

###
# Compass
###

# Susy grids in Compass
# First: gem install susy
 require 'susy'

# TODO - prod Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

# Dev Compass config
::Compass.configuration.sass_options = {
  :line_comments => true,
  :style => :expanded,
  :line_numbers => true
}

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
page "index.html" , :layout => :sitemap
page "documentation/*" , :layout => :documentation

# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy (fake) files
# page "/this-page-has-no-template.html", :proxy => "/template-file.html" do
#   @which_fake_page = "Rendering a fake page with a variable"
# end

###
# Helpers
###

# Automatic image dimensions on image_tag helper
activate :automatic_image_sizes

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do

  # For example, change the Compass output style for deployment
  #activate :minify_css

  # Minify Javascript on build
  #activate :minify_javascript

  # Create favicon/touch icon set from source/favicon_base.png
  #activate :favicon_maker

  # Enable cache buster
  # activate :cache_buster

  # Use relative URLs
  activate :relative_assets

  # Compress PNGs after build
  # First: gem install middleman-smusher
  # require "middleman-smusher"
  # activate :smusher

  # Or use a different image path
  # set :http_path, "/Content/images/"

  # Ignore readme's in build
  ignore '*.md' 
end