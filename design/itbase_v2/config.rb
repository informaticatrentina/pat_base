# Require any additional compass plugins here.
# require "C:/Users/IT449/Google Drive/Informatica Trentina/_Development/PTN/trunk/extension/pat_base/design/itbase_v2/css_splitter"
# it537
require "d:/Ez_Git/SVILUPPO/common_git_svilippo/repo102/extension/pat_base/design/itbase_v2/css_splitter"

# Set this to the root of your project when deployed:
http_path = "/"
css_dir = "stylesheets"
sass_dir = "scss"
images_dir = "images"
javascripts_dir = "javascript"

# You can select your preferred output style here (can be overridden via the command line):
# output_style = :expanded or :nested or :compact or :compressed
output_style = :compact

# To enable relative paths to assets via compass helper functions. Uncomment:
# relative_assets = true

# To disable debugging comments that display the original location of your selectors. Uncomment:
# line_comments = false


# If you prefer the indented syntax, you might want to regenerate this
# project again passing --syntax sass, or you can uncomment this:
# preferred_syntax = :sass
# and then run:
# sass-convert -R --from scss --to sass sass scss && rm -rf sass && mv scss sass

#add_import_path "C:/Users/IT449/Google Drive/Informatica Trentina/_Development/PTN/trunk/extension/ocbootstrap/design/ocbootstrap/scss"
#add_import_path "C:/Users/IT449/Google Drive/Informatica Trentina/_Development/PTN/trunk/extension/pat_base/design/itbase/scss"
# it537
add_import_path "d:/Ez_Git/community/extension/ocbootstrap/design/ocbootstrap/scss"
add_import_path "d:/Ez_Git/SVILUPPO/common_git_svilippo/repo102/extension/pat_base/design/itbase/scss"


on_stylesheet_saved do |path|
  CssSplitter.split(path) unless path[/\d+$/]
end 