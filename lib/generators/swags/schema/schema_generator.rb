require 'rails/generators'
require 'patch/rails/generators/generated_attribute'
require 'patch/factory_bot/generators/model_generator'

module Swags
  class SchemaGenerator < Rails::Generators::NamedBase # :nodoc:
    include Rails::Generators::ResourceHelpers
    include Rails::Generators::AppName

    def add_model_to_schema
      insert_into_file("config/swagger.yml", schema_content, after: "schemas:\n")
    end

    private

    def model
      class_name.to_s.constantize
    end

    def schema_content
      schema = ''
      schema += "    #{model.name}:\n"
      schema += "      properties:\n"
      model.columns.each do |c|
        schema += "        #{c.name}:\n"
        schema += "          description: '#{c.comment}'\n"
        schema += "          readOnly: true\n" if c.name == 'id' or c.name.end_with? "_at"
        schema += "          type: #{schema_type(c)}\n" unless c.array
        schema += "          format: #{schema_format(c)}\n" if schema_format(c)&&!c.array
        schema += "          type: array\n" if c.array
        schema += "          items:\n" if c.array
        schema += "            type: #{schema_type(c)}\n" if c.array
        schema += "            format: #{schema_format(c)}\n" if schema_format(c)&&c.array
      end
      schema
    end

    def schema_type(column)
      type = case column.type.to_sym
             when :uuid, :string, :date, :datetime
               'string'
             when :integer, :float
               'number'
             when :boolean
               'boolean'
             else
               column.type.to_s
             end
      type = "[#{type},null]" if column.null
      type
    end

    def schema_format(column)
      case column.type.to_sym
      when :uuid, :date
        column.type.to_s
      when :datetime
        'date-time'
      else
        nil
      end
    end
  end
end
