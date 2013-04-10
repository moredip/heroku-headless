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

  it "should call post-deploy actions" do
    heroku.post_app(:name => 'app_with_db')

    HerokuHeadless.configure do | config |
      config.post_deploy_commands = [
        'echo hello',
        'echo success'
      ]
    end

    HerokuHeadless::Deployer.any_instance.should_receive(:push_git)
    HerokuHeadless::Deployer.any_instance.should_receive(:run_command).with('echo hello')
    HerokuHeadless::Deployer.any_instance.should_receive(:run_command).with('echo success')

    HerokuHeadless::Deployer.deploy('app_with_db')
    $?.exitstatus.should eq 0
  end
end