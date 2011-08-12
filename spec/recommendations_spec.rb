#!/bin/env rspec

require "spec_helper"

describe "Recommendation.new(hash)" do
  raw = {
    :quote       => "Great to work with, intelligent feedback, exceptional quality.",
    :who         => "Matt Todd",
    :who_url     => "http://www.workingwithrails.com/person/7298-matt-todd",
    :where       => "Working with Rails",
    :where_url   => "http://www.workingwithrails.com/recommendation/for/person/7844-tammer-saleh",
    :position    => "Developer",
    :company     => "GitHub",
    :company_url => "http://github.com/",
    :short_quote => "Short"
  }

  before { @recommendation = Recommendation.new(raw) }
  subject { @recommendation }

  raw.each do |k, v|
    its(k) { should == v}
  end
end

describe "Recommendation.random" do
  before { @recommendation = Recommendation.random }
  subject { @recommendation }
  it { should be_a(Recommendation) }
end
