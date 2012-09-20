require "jefferson/version"

module Jefferson
  require 'yajl/json_gem'
  require 'active_support/core_ext/hash'
  require 'active_support/core_ext/object'
  require 'active_model'
  require 'typhoeus'
  require 'sanitize'
  require 'cgi'

  $LOAD_PATH.unshift(File.dirname(__FILE__))

  require 'jefferson/version.rb'
  require 'jefferson/config.rb'
  require 'jefferson/learning_resource.rb'
end
