# JC Middleman 3.0 Project Template: HTML5 Boilerplate HAML, Normalize, Susy, Sprockets Includes

HTML5 Boilerplate HAML is a project template for [Middleman 3.0](http://www.middlemanapp.com), a Sinatra-based static site generator by [Thomas Reynolds](http://awardwinningfjords.com/). It contains the a HAML-formatted version of the [HTML5 Boilerplate](http://www.html5boilerplate.com), as well as related assets broken up into a Middleman/Rails directory structure and included with Sprockets.

The JC version also includes a sample project README file, as well as extras in the `.gitignore` file

Using Bundler and RVM is **highly** recommended.

Other Features:

* [Middleman Livereload](https://github.com/middleman/middleman-livereload)
* [Middleman Favicon Maker](https://github.com/follmann/middleman-favicon-maker): creates favicons and touch icons on build from `favicon_base.png`
* [Susy 1.0.rc.1](http://susy.oddbird.net): mobile-first grid setup and ready to go at `stylesheets/partials/grid.css.scss`
* RVM-ready
* Some good `.gitignore` defaults

Hopefully this will save people some time. Add any suggestions to the [issue tracker](https://github.com/dannyprose/Middleman-HTML5-Boilerplate-HAML-Project-Template/issues).

## Usage

* Clone the git repo - `git clone https://github.com/jetcooper/middleman-template` to ~/.middleman
* Generate the Middleman structure by running `middleman init my_new_project --rack --template=middleman-template`

## Recommendations

* Update `.rvmrc` to the [gemset](https://rvm.io/gemsets/basics/) of your choosing (or remove it if you do not use [RVM](https://rvm.io/))
* Double check `.gitignore` and make sure it is what you want.
  * eg: `build/` is ignored by default.
* If you don't use `middleman init` to load the template, make sure to [use and run Bundler](http://gembundler.com/).

## Older Middleman Versions

This will likely work with Middleman 2.x, but it's optimized for Middleman 3.x. You might have a few manual tasks to perform (e.g. bundling after `middleman init`, changing `Gemfile` version numbers, etc.). 

## Customization
* The JC version includes some custom build filters to affect which pages appear on the index listing page and which files are built when running `middleman build`.  These are passed as options to the `activate :jc_index_builder` block in `config.rb`:
  * `:include_prototypes` - string - 'yes', 'no', 'only' (default: 'yes') - whether or not (or only) to include the prototypes directory, defined by the :prototypes_dir option
  * `:prototypes_dir` - string (default: 'prototypes/') - The directory used by the :include_prototypes option
  * `:group_directories` - bool (default: true) - Whether or not to sort the files by directory (with the directory name being rendered as an h2, with underscores converted to spaces and the first letter capitalized)
  * `:sitemap_partial` - string (default: 'partials/_render_sitemap.html.haml') - the location of the partial to be used to render the sitemap
  * `:exclude_directories` - array (default: []) - An array of directories to ignore from the sitemap, i.e. ['documentation', 'secret_dir'].  Worth noting that these are just the strings used to test file locations against.  Consequently, there's no nesting currently built in (more than the top level) and files containing this name will be excluded as well (so if you ignore the 'documentation' folder, '/documentation.html.haml' may be ignored too - needs more testing)
* You can also ignore individual templates by adding `hide_in_sitemap: true` to the YAML data at the top of a page (note: if changes aren't being reflected in the index page, try restarting your middleman server)