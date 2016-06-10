module EngagingNetworks
  class Campaign < Base
    def get(campaignId)
      client.get_request(data_path, {service: 'EaCampaignInfo', campaignId: campaignId,
            token_type: EngagingNetworks::Request::MultiTokenAuthentication::PUBLIC})
    end

    def create(name:, description:, ajax_enabled: true)
      scrape.create_campaign(name: name, description: description, ajax_enabled: ajax_enabled)
    end

    # implements https://www.e-activist.com/ea-dataservice/import.jsp
    def duplicate(a)
      # accept either hashes or objects as input
      action = if a.is_a?(Hash)
            DuplicateCampaignAction.new(a)
          else
            a
          end

      # if the token is blank, default it to the configured private token
      action.token = client.connection.configuration.options[:private_token] if action.token.blank?

      if action.valid?
        response = client.request_with_options(:post, import_path, action.to_params, content_type: 'multipart/form-data')
        if response.body =~ /uploaded successfully/
          action.job_id = /# is (\d*)/.match(response.body)[1]
        else
          raise "error while duplicating campaign: #{response.body}"
        end
      end

      action
    end

    def search(campaign_name)
      response = client.get_request(data_path, {service: 'EaCampaignInfo', token_type: EngagingNetworks::Request::MultiTokenAuthentication::PUBLIC})
      if response.obj.is_a? EngagingNetworks::Response::Collection
        response.obj.objects.find { |elem| elem.campaignName == campaign_name }
      elsif response.obj.is_a? EngagingNetworks::Response::Object
        response.obj ? response.obj.campaignName == campaign_name : nil
      else
        nil
      end
    end

  end
end
