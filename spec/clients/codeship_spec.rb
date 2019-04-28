require "spec_helper"
require "./app/clients/codeship/api"

RSpec.describe Codeship do
  it "has a base endpoint" do
    expect(described_class::ENDPOINT).to eq("https://api.codeship.com")
  end
end
