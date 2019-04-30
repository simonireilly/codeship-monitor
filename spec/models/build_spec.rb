require "spec_helper"
require "./app/models/build"

RSpec.describe Build do
  it "persists valid build data" do
    build = JSON.parse(File.read("./spec/fixtures/valid_build.json"))
    Build.safe_update(build)
    expect(Build.count).to eq(1)
  end
end
