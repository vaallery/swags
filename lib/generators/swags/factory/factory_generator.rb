module Swags
  class FactoryGenerator < Rails::Generators::NamedBase
    # include Rails::Generators::ResourceHelpers
    # include Rails::Generators::AppName
    source_root File.expand_path('../templates', __FILE__)
    def generate_components
      generate 'factory_bot:model', class_name, *(model.attrs)
    end

    private

    def model
      class_name.to_s.constantize
    end
  end
end
