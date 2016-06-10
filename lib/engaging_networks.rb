require 'vertebrae'

module EngagingNetworks
  extend Vertebrae::Base

  class << self
    def new(options = {})
      EngagingNetworks::Client.new(options)
    end
  end
end

require 'active_support/all'
require 'active_model'
require 'stringio'
require 'mechanize'

require 'engaging_networks/version'
require 'engaging_networks/client'
require 'engaging_networks/base'
require 'engaging_networks/campaign'
require 'engaging_networks/supporter'
require 'engaging_networks/action'
require 'engaging_networks/action_model'
require 'engaging_networks/duplicate_campaign_action'
require 'engaging_networks/action_create_action'

require 'engaging_networks/response/wrapper'
require 'engaging_networks/response/raise_error'
require 'engaging_networks/response/collection'
require 'engaging_networks/response/object'

require 'engaging_networks/scrape/client'
