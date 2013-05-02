module JCIndexBuilder
  class << self

    def registered(app, options_hash={})
      default_options = {
        :include_prototypes => 'yes',
        :prototypes_dir => 'prototypes/',
        :group_directories => true,
        :sitemap_partial => 'partials/_render_sitemap.html.haml',
        :exclude_directories => []
      }
      options = default_options.merge(options_hash)
      app.set :jc_feature_options, options

      app.after_configuration do 
        sitemap.register_resource_list_manipulator(
          :my_feature,
          JCSitemapManipulator.new(self, options),
          true
        )
      end
      app.send :include, Helpers
    end

    alias :included :registered
  end


  # Helpers module - helpers globally accessible to Middleman
  module Helpers
    # render_sitemap - groups files into directories when requested
    # by params, returns rendered haml template specified in the
    # :sitemap_partial param.
    def render_sitemap
      options = jc_feature_options
      prototypes_folder = options[:prototypes_dir].gsub('/','')

      if options[:group_directories]
        directories = []
        sitemap.resources.find_all{|p| p.source_file.match(/\.html/) }.each do |b|
          first_seg = b.destination_path.split('/')[0].split('_').map{|x| x.capitalize }.join(' ')
          if !first_seg.include? '.html' and !directories.include? first_seg
            directories.push first_seg
          end
        end
        directories.push 'global'
        groupings = Hash[directories.map {|v| [v, []]}]

        sitemap.resources.find_all{|p| p.source_file.match(/\.html/) }.each do |b|
          first_seg = b.destination_path.split('/')[0].split('_').map{|x| x.capitalize }.join(' ')
          if !first_seg.include? '.html'
            groupings[first_seg].push(b)
          elsif !b.source_file.include? 'index.html'
            groupings['global'].push(b)
          end
        end
      end

      render_individual_file(options[:sitemap_partial], {
        :options => options,
        :groupings => groupings})
   end
  end


  # JCSitemapManipulator - Informs the Middleman sitemap to remove
  # pages according to config.rb variables
  class JCSitemapManipulator

    def initialize(app, options)
      @app = app
      @options = options
    end

    def manipulate_resource_list(resources)
      resources.each do |resource|

        if @options[:include_prototypes] == 'no'  and
          resource.source_file.include? (@options[:prototypes_dir]) and
          !resource.source_file.include? 'index.html'
            @app.ignore resource.destination_path
        elsif @options[:include_prototypes] == 'only'
          if !resource.source_file.include? (@options[:prototypes_dir]) and
            resource.source_file.include? '.html' and
            !resource.source_file.include? 'index.html'
              @app.ignore resource.destination_path
          end
        end

        # Remove excluded folders from sitemap (1 level deep)
        if !@options[:exclude_directories].empty?
          @options[:exclude_directories].map! {|x| x.gsub('/', '') }
          if @options[:exclude_directories].include? resource.destination_path.split('/')[0] and
            resource.source_file.include? '.html'
              @app.ignore resource.destination_path
          end
        end

        #Remove if flagged in template YAML
        if resource.data.hide_in_sitemap.present? and resource.data.hide_in_sitemap === true
          @app.ignore resource.destination_path
        end

      end
    end

  end

end
::Middleman::Extensions.register(:jc_index_builder, JCIndexBuilder)

