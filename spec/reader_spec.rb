require 'rss-cli'
require 'rspec'
require 'flexmock'

RSpec.configure do |config|
  config.mock_with :flexmock
  config.expect_with(:rspec) { |c| c.syntax = :should }
end

RSpec.describe Reader, "#Feed Selection:" do
  context "When the reader selects a feed" do
    let(:cliMock) { flexmock("cli", :on,  HighLine) }
    it "shows the selection of feeds" do
      reader = Reader.new :cli => cliMock
      reader.read
      cliMock.should have_received(:say).with("Your RSS feeds:")
      cliMock.should have_received(:choose)
    end
  end
end
