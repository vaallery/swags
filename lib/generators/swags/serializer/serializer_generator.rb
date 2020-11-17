require 'rails/generators'

module Swags
  class SerializerGenerator < ::Rails::Generators::NamedBase
    include Rails::Generators::ResourceHelpers
    source_root File.expand_path('../templates', __FILE__)

    def create_serializer_file
      template("serializer.rb.erb", File.join("app/serializers", controller_class_path, "#{file_name}_serializer.rb"))
    end
  end
end
