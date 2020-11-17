# frozen_string_literal: true

# require 'rswag/route_parser'
require 'rails/generators'

module Swags
  class RspecGenerator < ::Rails::Generators::NamedBase
    include Rails::Generators::ResourceHelpers

    source_root File.expand_path('templates', __dir__)

    def create_spec_file
      template 'spec.rb.erb', File.join('spec', 'requests', "#{plural_file_name}_spec.rb")
      resource
    end

    private

    def up_id
      "#{singular_table_name.upcase}_ID"
    end

    def resource
      singular_table_name
    end

    def resources
      plural_table_name
    end

    def classes_name
      class_name.pluralize
    end

    def controller_path
      file_path.chomp('_controller')
    end
  end
end
