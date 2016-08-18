# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: engaging_networks 0.2.1 ruby lib

Gem::Specification.new do |s|
  s.name = "engaging_networks"
  s.version = "0.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Josh Levinger", "Nathan Woodhull"]
  s.date = "2016-06-10"
  s.description = "Gem for interacting with the Engaging Networks API"
  s.email = "josh@levinger.net"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    ".rspec",
    ".ruby-gemset",
    ".ruby-version",
    ".travis.yml",
    "Gemfile",
    "Gemfile.lock",
    "Guardfile",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "engaging_networks.gemspec",
    "lib/engaging_networks.rb",
    "lib/engaging_networks/action.rb",
    "lib/engaging_networks/action_create_action.rb",
    "lib/engaging_networks/action_model.rb",
    "lib/engaging_networks/api.rb",
    "lib/engaging_networks/base.rb",
    "lib/engaging_networks/campaign.rb",
    "lib/engaging_networks/client.rb",
    "lib/engaging_networks/duplicate_campaign_action.rb",
    "lib/engaging_networks/request/multitoken.rb",
    "lib/engaging_networks/response/collection.rb",
    "lib/engaging_networks/response/object.rb",
    "lib/engaging_networks/response/raise_error.rb",
    "lib/engaging_networks/response/wrapper.rb",
    "lib/engaging_networks/scrape/client.rb",
    "lib/engaging_networks/supporter.rb",
    "lib/engaging_networks/version.rb",
    "spec/engaging_networks/action_create_action_spec.rb",
    "spec/engaging_networks/action_spec.rb",
    "spec/engaging_networks/campaign_spec.rb",
    "spec/engaging_networks/collection_spec.rb",
    "spec/engaging_networks/duplicate_campaign_action_spec.rb",
    "spec/engaging_networks/supporter_spec.rb",
    "spec/fixtures/EaCampaignInfo/failure.xml",
    "spec/fixtures/EaCampaignInfo/success.xml",
    "spec/fixtures/EaCampaignInfo/success_array.xml",
    "spec/fixtures/SupporterData/aoxml_success.xml",
    "spec/fixtures/SupporterData/aoxml_success_array.xml",
    "spec/fixtures/SupporterData/failure.xml",
    "spec/fixtures/SupporterData/success.xml",
    "spec/fixtures/action/api_success.json",
    "spec/fixtures/action/error.json",
    "spec/fixtures/action/success.json",
    "spec/fixtures/api-supporter-template.csv",
    "spec/fixtures/import.service/error.txt",
    "spec/fixtures/import.service/success.txt",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/jlev/engaging_networks"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.8"
  s.summary = "A wrapper for the Engaging Networks API"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<vertebrae>, [">= 0"])
      s.add_runtime_dependency(%q<json>, [">= 0"])
      s.add_runtime_dependency(%q<activesupport>, [">= 3.2"])
      s.add_runtime_dependency(%q<activemodel>, [">= 3.2"])
      s.add_runtime_dependency(%q<mechanize>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 3.4"])
      s.add_development_dependency(%q<webmock>, [">= 0"])
      s.add_development_dependency(%q<pry-byebug>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, ["~> 2.0.0"])
    else
      s.add_dependency(%q<vertebrae>, [">= 0"])
      s.add_dependency(%q<json>, [">= 0"])
      s.add_dependency(%q<activesupport>, [">= 3.2"])
      s.add_dependency(%q<activemodel>, [">= 3.2"])
      s.add_dependency(%q<mechanize>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 3.4"])
      s.add_dependency(%q<webmock>, [">= 0"])
      s.add_dependency(%q<pry-byebug>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<jeweler>, ["~> 2.0.0"])
    end
  else
    s.add_dependency(%q<vertebrae>, [">= 0"])
    s.add_dependency(%q<json>, [">= 0"])
    s.add_dependency(%q<activesupport>, [">= 3.2"])
    s.add_dependency(%q<activemodel>, [">= 3.2"])
    s.add_dependency(%q<mechanize>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 3.4"])
    s.add_dependency(%q<webmock>, [">= 0"])
    s.add_dependency(%q<pry-byebug>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<jeweler>, ["~> 2.0.0"])
  end
end

