module EngagingNetworks
  class Base < Vertebrae::Model

    def import_path
      "/ea-dataservice/import.service"
    end

    def data_path
      "/ea-dataservice/data.service"
    end

    def export_path
      "/ea-dataservice/export.service"
    end

    def action_path
      "/ea-action/action"
    end

    def scrape
      @scrape ||= EngagingNetworks::Scrape::Client.new(username: client.connection.configuration.options[:username], password: client.connection.configuration.options[:password])
    end

  end
end
