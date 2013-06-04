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

  context "forced pushs" do
    let(:headless) { HerokuHeadless::Deployer.new("forced_app", HerokuHeadless::CreatesUIDs.generate_uid) }
    subject { headless.send(:git_push_command) }

    context "enabled forced push" do
      before do
        HerokuHeadless.configure do | config |
          config.force_push = true
        end
      end
      it {should eq "git push -f git@heroku.com:forced_app.git HEAD:master"}
    end

    context "disabled forced push" do
      before do
        HerokuHeadless.configure do | config |
          config.force_push = false
        end
      end
      it {should eq "git push git@heroku.com:forced_app.git HEAD:master"}
    end
  end

  it "should run the git pre-deploy commands" do
    @app_name = 'app_with_configuration_changes'
    heroku.post_app(:name => @app_name)
    HerokuHeadless.configure do | config |
      config.pre_deploy_git_commands = [
        "git checkout master",
        "git remote add heroku git@heroku.com:#{@app_name}.git"
      ]
    end

    HerokuHeadless::Deployer.any_instance.should_receive(:push_git).and_return(true)
    HerokuHeadless::Deployer.any_instance.should_receive(:run_git_command).with("git checkout master")
    HerokuHeadless::Deployer.any_instance.should_receive(:run_git_command).with("git remote add heroku git@heroku.com:#{@app_name}.git")

    result = HerokuHeadless::Deployer.deploy(@app_name)
    result.should be_true

  end


end
