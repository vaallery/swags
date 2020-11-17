
require 'rails/generators'

module Swags
  class FilterGenerator < Rails::Generators::NamedBase
    include Rails::Generators::ResourceHelpers
    include Rails::Generators::AppName
    source_root File.expand_path('../templates', __FILE__)

    def create_filter_file
      template("filter.rb.erb", File.join("app/filters", controller_class_path, "#{controller_file_name}_filter.rb"))
    end
  end
end
