require 'spec_helper'

describe EngagingNetworks::Campaign do
  let!(:en) { EngagingNetworks.new(public_token: 'TEST_PUBLIC_TOKEN', private_token: 'TEST_PRIVATE_TOKEN') }

  before(:each) do
    logger = double
    logger.stub(:debug).and_return(true)

    EngagingNetworks.stub(:logger).and_return(logger)
    Vertebrae::Base.stub(:logger).and_return(logger)
  end


  describe "retrieval" do
    let(:request_path) { 'https://e-activist.com/ea-dataservice/data.service' }

    before(:each) do
      stub_get(request_path).with(:query => hash_including({:service => 'EaCampaignInfo'})).
        to_return(:body => body, :status => status, :headers => {:content_type => "text/xml;charset=UTF-8"})
    end

    describe "exists" do
      let(:body) { fixture('EaCampaignInfo/success.xml') }
      let(:status) { 200 }

      it 'should exist' do
        c = en.campaign.get(26967)
        c.campaignId.should == '26967'
        c.campaignName.should == 'API Test Campaign'
        c.campaignStatus.should == 'Live'
      end
    end

    describe 'does not exist' do
      let(:body) { fixture('EaCampaignInfo/failure.xml') }
      let(:status) { 200 }

      it "should be empty" do
        c = en.campaign.get(1234)
        c.kind.should == :empty
        c.obj.should == nil
      end
    end
  end

  describe 'duplicate' do
    let(:request_path) { 'https://e-activist.com/ea-dataservice/import.service' }
    let(:status) { 200 }
    before(:each) do
      stub_post(request_path).to_return(:body => body, :status => status, :headers => {:content_type => "text/html;charset=UTF-8"})
    end

    let(:params) do {reference_name: 'foo',
                    format_name: 'API New Supporter Template',
                    csv_string: 'Email,First Name,Last Name,City,Country Code,Country Name,Postal Code,Mobile Phone,Language,Originating Action',
                    csv_file_name: 'upload.csv'}
                 end

    describe 'success' do
      let(:body) { fixture('import.service/success.txt') }

      it 'should get back a job id' do
        action = en.campaign.duplicate params
        expect(action.job_id).to eq('131878')
      end
    end

    describe 'error' do
      let(:body) { fixture('import.service/error.txt') }

      it 'should raise an exception' do
        expect { en.campaign.duplicate(params) }.to raise_error(EngagingNetworks::CampaignDuplicationError).with_message('error while duplicating campaign: Error: Unable to process your import. Please contact support.')
      end
    end
  end

  describe 'search' do
    let(:request_path) { 'https://e-activist.com/ea-dataservice/data.service' }

    before(:each) do
      stub_get(request_path).with(:query => hash_including({:service => 'EaCampaignInfo'})).
        to_return(:body => body, :status => status, :headers => {:content_type => "text/xml;charset=UTF-8"})
    end

    describe "search" do
      let(:body) { fixture('EaCampaignInfo/success_array.xml') }
      let(:status) { 200 }

      it 'should find by name' do
        c = en.campaign.search("API Test Campaign")
        expect(c.campaignName).to eq('API Test Campaign')
      end

      it 'should find by name with only one record returned' do
        c = en.campaign.search("API Test Campaign2")
        expect(c.campaignName).to eq('API Test Campaign2')
      end

      it 'should return nil if nothing is found' do
        c = en.campaign.search("Foobar")
        expect(c).to eq(nil)
      end
    end

    let(:body) { fixture('EaCampaignInfo/success_array.xml') }
    let(:status) { 200 }
  end
end
