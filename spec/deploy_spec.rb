require 'spec_helper'

describe 'HerokuHeadless' do
  let(:heroku) { HerokuHeadless.heroku }

  it "should fail to deploy a missing app" do
    HerokuHeadless::Deployer.deploy('missing_app')
    $?.exitstatus.should_not eq 0
  end

  it "should successfully deploy an existing app" do
    heroku.post_app(:name => 'existing_app')
    # Creating an app on heroku actually isn't enough to make the git push pass!
    HerokuHeadless::Deployer.any_instance.should_receive(:push_git)
    HerokuHeadless::Deployer.deploy('existing_app')
    $?.exitstatus.should eq 0
  end
end