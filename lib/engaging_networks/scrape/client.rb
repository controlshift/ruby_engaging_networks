module EngagingNetworks
  module Scrape
    class Client
      attr_accessor :username, :password

      HOST = 'www.e-activist.com'

      def initialize(username:, password:)
        self.username = username
        self.password = password
      end

      def login
        agent.get("https://#{HOST}/ea-account/index.jsp") do |page|

          page.form_with(name: 'accountLF') do |login|
            login.set_fields('_f_0' => username, '_f_1' => password)
          end.submit
        end
      end

      def create_campaign(name:, description:, ajax_enabled: true)
        login

        campaign_id = nil

        agent.get("https://#{HOST}/ea-account/auth/") do |page|
          new_campaign_form = agent.click(page.link_with(:text => /Create a Campaign/))

          new_campaign_result = new_campaign_form.form_with(name: 'campaignForm') do |campaign|
            campaign.set_fields({'_f_0' => name,
                                '_f_1' => description,
                                '_f_2' => '2', # data capture type
                                #'_f_3' => '3', # new campaign option is not show on new campaign form.
                                'dc_subtype' => 'DCF',
                                'dc_mem_val' => '',
                                '_f_12' => ''
                                })

            campaign.radiobutton_with(:name => '_f_4').value = ajax_enabled ? 'true' : 'false'

          end.submit

          campaign_list = agent.click(new_campaign_result.link_with(:text => /Manage Campaigns/))
          campaign_form = campaign_list.form_with(action: 'https://www.e-activist.com/ea-account/auth/campaign.jsp')
          campaign_id = campaign_form.field_with(name: 'ea.campaign.id').value
        end
        campaign_id
      end

      def build_form(id)
        # TODO some sort of API for building campaign forms
        "/ea-account/auth/action.menu.do?v=c:showBuild&ea-account.campaign.id=#{id}"
      end

      def agent
        @agent ||= ::Mechanize.new do |agent|
          agent.user_agent = 'Engaging Networks Ruby Gem'
        end
      end

    end
  end
 end
