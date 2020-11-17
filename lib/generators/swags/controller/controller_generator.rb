
require 'rails/generators'

module Swags
  class ControllerGenerator < ::Rails::Generators::NamedBase
    include Rails::Generators::ResourceHelpers
    source_root File.expand_path('../templates', __FILE__)

    # check_class_collision suffix: "Controller"

    class_option :orm, banner: "NAME", type: :string, required: true,
                 desc: "ORM to generate the controller for"

    def create_controller_file
      template("controller.rb.erb", File.join("app/controllers", controller_class_path, "#{controller_file_name}_controller.rb"))
      route("resources :#{plural_name}")
    end

    private
    def attributes_names # :doc:
      @attributes_names ||= get_model_attributes.each_with_object([]) do |a, names|
        names << a.column_name
        names << "password_confirmation" if a.password_digest?
        names << "#{a.name}_type" if a.polymorphic?
      end
    end

    def permitted_params
      attachments, others = attributes_names.partition { |name| attachments_or_array?(name) }
      params = others.map { |name| ":#{name}" }
      params += attachments.map { |name| "#{name}: []" }
      params.join(", ")
    end

    def get_model_attributes
      @attributes = attrs.map { |attr| Rails::Generators::GeneratedAttribute.parse(attr) }
    rescue => ex
      puts ex
      puts "problem with model #{class_name}"
      return nil
    end

    def attachments_or_array?(name)
      attribute = @attributes.find { |attr| attr.name == name }
      attribute&.attachments? || attribute&.has_array?
    end

    def attrs
      # don't edit id, foreign keys (*_id), timestamps (*_at)
      @attrs ||= model.columns.reject do |a|
        n = a.name
        n == "id" or n.end_with? "_at" # or n.end_with? "_id"
      end .map do |a|
        # name:type just like command line
        # name:type:array just like command line
        attr = [a.name,a.type.to_s]
        attr << 'array' if a.array
        attr.join(':')
      end
    end

    def model
      class_name.to_s.constantize
    end

    def model_name
      model.name
    end
  end
end