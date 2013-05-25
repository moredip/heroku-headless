require 'spec_helper'

describe 'HerokuHeadless' do
  let(:heroku) { HerokuHeadless.heroku }

  it "should fail to deploy a missing app" do
    result = HerokuHeadless::Deployer.deploy('missing_app')
    result.should be_false
  end

  it "should successfully deploy an existing app" do
    heroku.post_app(:name => 'existing_app')
    # Creating an app on heroku actually isn't enough to make the git push pass!
    HerokuHeadless::Deployer.any_instance.should_receive(:push_git).and_return(true)
    result = HerokuHeadless::Deployer.deploy('existing_app')
    result.should be_true
  end

  it "should call post-deploy actions" do
    heroku.post_app(:name => 'app_with_db')

    HerokuHeadless.configure do | config |
      config.post_deploy_commands = [
        'echo hello',
        'echo success'
      ]
    end

    HerokuHeadless::Deployer.any_instance.should_receive(:push_git).and_return(true)
    HerokuHeadless::Deployer.any_instance.should_receive(:run_command).with('echo hello')
    HerokuHeadless::Deployer.any_instance.should_receive(:run_command).with('echo success')

    result = HerokuHeadless::Deployer.deploy('app_with_db')
    result.should be_true
  end
end
