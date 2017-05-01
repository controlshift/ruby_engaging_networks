require 'spec_helper'

describe EngagingNetworks::Action do
  let!(:en) { EngagingNetworks.new(public_token: 'TEST_PUBLIC_TOKEN', private_token: 'TEST_PRIVATE_TOKEN') }

  describe 'create' do
    let(:request_path) { 'https://e-activist.com/ea-action/action' }
    let(:body) { fixture('action/success.json') }
    let(:status) { 200 }
    let(:input_hash) do
      { client_id: 123, campaign_id: 123, form_id: 123, first_name: 'George',
      last_name: 'Washington', city: 'Detroit', country: 'US', country_name: 'United States',
      email: 'george@washington.com', address_line_1: 'address1', address_line_2: 'address2',
      post_code: '02052', state: 'MI', mobile_phone: '518-207-6768', originating_action: 'xxx',
      additional_fields: {}}
    end

    before(:each) do
      stub_request(:post, request_path).with(:query => {'format' => 'json'},
                                             :headers => {'Accept'=>'application/json;q=0.1',
                                                          'Accept-Charset'=>'utf-8',
                                                          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                                                          'Content-Type'=>'application/x-www-form-urlencoded',
                                                          'User-Agent'=>'EngagingNetworksGem'}).
        to_return(:body => body, :status => status, :headers => {:content_type => "text/json;charset=UTF-8"})
    end

    describe 'success: response format A' do
      let(:body) { fixture('action/success.json') }

      it 'should create an action' do
        c = en.action.create(input_hash)
        expect(c.result).to be_truthy
      end
    end

    describe 'success: response format B' do
      let(:body) { fixture('action/api_success.json') }

      it 'should create an action' do
        c = en.action.create(input_hash)
        expect(c.result).to be_truthy
      end
    end

    describe 'failure' do
      let(:body) { fixture('action/error.json') }

      it 'should raise' do
        expect { en.action.create(input_hash) }.to raise_error(EngagingNetworks::InvalidActionError)
      end
    end

    describe 'invalid json' do
      let(:body) { '{hello: unclosed'}

      it 'should raise' do
        expect { en.action.create(input_hash) }.to raise_error(EngagingNetworks::InvalidJsonResponseError)
      end
    end
  end
end
