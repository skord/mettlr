require "mettlr/version"
require 'faraday'
require 'faraday_middleware'
require 'openssl'
require 'base64'
require 'hashie'
require 'active_support'
require 'json'

require "mettlr/connection"
require "mettlr/sig_gen"
require "mettlr/models/base"
require "mettlr/models/account"
require "mettlr/models/assessment"
require "mettlr/models/schedule"
require "mettlr/models/candidate"

module Mettlr
  METTL_PUBLIC_KEY = ENV['METTL_PUBLIC_KEY']
  METTL_PRIVATE_KEY = ENV['METTL_PRIVATE_KEY']
end

