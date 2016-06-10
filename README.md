# engaging_networks

A ruby binding for the Engaging Networks API

[![Build Status](https://travis-ci.org/controlshift/ruby_engaging_networks.svg)](https://travis-ci.org/controlshift/ruby_engaging_networks)

This API client wraps undocumented features of the Engaging Networks platform in ruby bindings that can be used to approximate
API-ish behavior. It does not use the [ENS API](https://speca.io/engagingnetworks/engaging-network-services?key=726cda99f0551ef286486bb847f5fb5d) and is intended
as a stopgap until EN builds out a full API.

## Usage

create a client object

```ruby
require 'engaging_networks'
en = EngagingNetworks.new({public_token: 'PUBLIC_TOKEN',private_token: 'PRIVATE_TOKEN'})
```

Get a campaign by id

```ruby
campaign = en.campaign.get 456
campaign.obj
=> #<EngagingNetworks::Response::Object:0x00000101685f68
 @fields=
  {"clientId"=>"123",
   "campaignId"=>"456",
   "campaignStatus"=>"Live",
   "campaignName"=>"Test Campaign",
   "campaignExportName"=>"Test Campaign",
   "description"=>nil}>
```

Duplicate a campaign


```ruby
action = en.campaign.duplicate reference_name: 'foo',
                      format_name: 'API New Supporter Template',
                      csv_string: 'Email,First Name,Last Name,City,Country Code,Country Name,Postal Code,Mobile Phone,Language,Originating Action',
                      csv_file_name: 'upload.csv',
                      segment_id: 'Test Segment Id',
                      segment_name: 'Test Segment',
                      template_campaign_id: 26967,
                      new_campaign_reference_name: 'New Test Campaign4'
action.job_id
=> '1234'
```

Create a campaign via screen scrape
```ruby
id = en.campaign.create(name: 'ControlShift test 2', description: 'description')
# returns the campaign id
```

Search for a campaign by name (exact match only)

```ruby
action = en.campaign.search "Foo"
action.campaignName
=> 'Foo'
```

check if supporter exists

```ruby
en.supporter.exists? 'email@example.com'
=> false
```
create an action

```ruby
action = en.action.create(client_id: 123, campaign_id: 123, form_id: 123, first_name: 'George',
                          last_name: 'Washington', city: 'Detroit', country: country_code, country_name: 'United States',
                          email: 'george@washington.com', address_line_1: 'address1', address_line_2: 'address2',
                          post_code: '02052', state: 'MI', mobile_phone: '518-207-6768', originating_action: 'xxx',
                          opt_in: true,
                          additional_fields: {'Some Custom Field Name': 'field value'})

action.valid?
=> true
action.result
=> true
```

The truth of the opt_in field determines whether or not the member is opted in.

And then check again, and now supporter exists!

```ruby
en.supporter.exists? 'email@example.com'
=> true
```

Supporters by date

```
en.supporter.export Date.new(2014,6,5)
=> [{...}]

```

## Copyright

Copyright (c) 2015 ChangeSprout Inc. See LICENSE.txt for
further details.

