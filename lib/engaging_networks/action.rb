require 'json'
require 'nokogiri'

module EngagingNetworks
  class InvalidActionError < StandardError ; end
  class InvalidJsonResponseError < StandardError ; end

  class Action < Base
    # individual get unavailable
    # need to export and search actions
    def export(startDate)
      client.get_request(data_path, {startDate: startDate,
          token_type: EngagingNetworks::Request::MultiTokenAuthentication::PRIVATE})
    end

    def create(action_hash, additional_options = {})
      # accept either hashes or objects as input
      action = if action_hash.is_a?(Hash)
                 ActionCreateAction.new(action_hash)
               else
                 action_hash
               end

      if action.valid?
        # parameters required for fake ajax form submission
        ajax_form_params = {
          'ea.AJAX.submit' => true,
          'ea.submitted.page' => 1,
          'ea_requested_action' => 'ea_submit_user_form',
          'ea_javascript_enabled' => true,
          'ea.campaign.mode' => 'DEMO',
          'ea.retain.account.session.error' => true,
          'ea.clear.campaign.session.id' => true,
          'v' => 'c%3AshowBuild'
        }

        # clientId, campaignId, formId
        client_params = {'ea.client.id' => action.client_id,
                         'ea.campaign.id' => action.campaign_id,
                         'ea.form.id' => action.form_id}

        # merge params hashes
        post_params = {}
        post_params = post_params.merge(ajax_form_params)
        post_params = post_params.merge(client_params)
        post_params = post_params.merge(action.to_params)
        post_params = post_params.merge(additional_options)

        # call post request, with get param ?format=json
        rsp = client.post_request_with_get_params(action_path, {'format'=>'json'}, post_params)
        action.raw_response = rsp
        body = rsp.body
        begin
          json_body = JSON.parse(body)
        rescue JSON::ParserError => e
          raise EngagingNetworks::InvalidJsonResponseError.new("Unable to parse JSON, Engaging Networks responded with: #{ body }; json: #{e.message} headers: #{rsp.headers} status: #{rsp.status}")
        end

        # parse json for first form field, apisuccess div
        if json_body['messages'].empty? || body =~ /apisuccess/
          if body =~ /apisuccess/
            success_div = json_body['pages'][0]['form']['fields'][0]['value']

            # TODO, this seems really fragile...
            action.result = Nokogiri::HTML(success_div).css('#apisuccess').text == "success"
          else
            action.result = true
          end
        else
          raise EngagingNetworks::InvalidActionError.new("Engaging Networks responded with: #{ body }")
        end

        action
      else
        action
      end
    end

  end
end
