# This is NOT THE SAME as cache_classes. cache_classes would make us restart the dev server on any change.
# This merely loads all models, necessary for Rails.cache to not throw errors.
# Thanks http://aaronvb.com/articles/37-rails-caching-and-undefined-class-module.
# if Rails.env == "development"
#   Dir.foreach("#{Rails.root}/app/models") do |model_name|
#     require_dependency model_name unless model_name == "." || model_name == ".."
#   end 
# end
