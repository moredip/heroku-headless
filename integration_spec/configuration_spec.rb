require 'rspec'
require 'heroku-headless'
# Do not include spec_helper, because it has a HerokuHeadless.configure block

describe 'HerokuHeadless' do
  it "should have a default configuration" do
    HerokuHeadless.configuration = nil
    HerokuHeadless.configuration.mock_mode.should == false
  end
end