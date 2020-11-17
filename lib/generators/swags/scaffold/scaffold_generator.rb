# frozen_string_literal: true

require 'rails/generators'
require 'patch/rails/generators/generated_attribute'
require 'patch/factory_bot/generators/model_generator'

module Swags
  class ScaffoldGenerator < Rails::Generators::NamedBase # :nodoc:
    include Rails::Generators::ResourceHelpers
    include Rails::Generators::AppName

    source_root File.expand_path('../templates', __FILE__)
    #
    # class_option :orm, banner: "NAME", type: :string, required: true,
    #                    desc: "ORM to generate the controller for"

    def generate_components
      generate 'swags:finder', class_name
      generate 'swags:filter', class_name
      generate 'swags:serializer', class_name
      generate 'swags:controller', class_name
      generate 'swags:factory', class_name
      generate 'swags:schema', class_name
      generate 'swags:rspec', class_name
    end
  end
end
