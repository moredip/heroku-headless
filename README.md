[![Build Status](https://secure.travis-ci.org/moredip/heroku-headless.png?branch=master)](http://travis-ci.org/moredip/heroku-headless)
[![Dependency Status](https://gemnasium.com/moredip/heroku-headless.png?travis)](https://gemnasium.com/moredip/heroku-headless)
[![Code Climate](https://codeclimate.com/github/moredip/heroku-headless.png)](https://codeclimate.com/github/moredip/heroku-headless)

# HerokuHeadless

## What?
Push from your git repo to a heroku app without any external configuration.

## Why?
Heroku's workflow is geared towards pushing to a heroku app from a dev workstation. This gem makes it easy to push to a heroku app as part of a CI/CD setup.

## Installation

Add this line to your application's Gemfile:

    gem 'heroku-headless'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install heroku-headless

## How do I use this?
It's as simple as
```ruby
require 'heroku-headless'
HerokuHeadless::Deployer.deploy( 'your-app-name' )
```

### Use it with pre- and post-commands:

```ruby
require 'heroku-headless'

  app_name = 'my-heroku-app-name'
  remote_name = 'herokuheadless'

  puts "deploying to heroku app #{app_name}"
  remote_name = "headlessheroku"
  HerokuHeadless.configure do | config |
    config.post_deploy_commands = ['rake db:migrate']
    config.pre_deploy_git_commands = [
      "git remote -v",
      "git checkout master",
      "git commit -am  \"changes from headless deploy\" ",
      "git remote add #{remote_name} git@heroku.com:#{app_name}.git",
      "git fetch #{remote_name}",
      "git merge -m \"merged by automatic deploy\" #{remote_name}/master"]
  end

  result = HerokuHeadless::Deployer.deploy( app_name )
  puts "successfully deployed to #{app_name}" if result
  exit result ? 0 : 1

```

## Tell me more!

[Deploying To Heroku From CI](http://blog.thepete.net/blog/2013/01/21/deploying-to-heroku-from-ci)

[Deploying to Heroku From CI - the Gory Details](http://blog.thepete.net/blog/2013/01/22/deploying-to-heroku-from-ci-the-gory-details/)
