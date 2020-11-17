# frozen_string_literal: true

require "swags/version"

require 'rails/generators'
require 'patch/active_record/base'
require 'patch/rails/generators/generated_attribute'
require "patch/factory_bot/generators/model_generator"

require 'generators/swags/scaffold/scaffold_generator'

module Swags
  class Error < StandardError; end
  # Your code goes here...
end
