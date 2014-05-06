# Rvmpow

[![Gem Version](https://badge.fury.io/rb/rvmpow.svg)](http://badge.fury.io/rb/rvmpow)

`rvmpow` is usefull only if you:

- use MacOS X
- use [rvm](http://rvm.io)
- use [pow](http://pow.cx)
- are a [rails](http://rubyonrails.org/) developper or develop [Rack](https://rack.github.io/) apps

[Pow](http://pow.cx) needs to know what ruby and gemset is being used. rvm users can provide this information [manually](http://rvm.io/integration/pow) or install `rvmpow` and it'll handle it for you, including adding the new configuration file to .gitignore and linking the new app for immediate browsing.

**Words of caution**

I tested on newly created and updated rails apps, a bare minimal rack "*app*" and a bare minimal Sinatra app. Feedback is more than welcome.

If you are already specifying the ruby version and gemset via .rvmrc or .ruby-version/.ruby-gemset or in your Gemfile, be aware that rvmpow uses Gemfile (which is a good thing  if you're going to deploy to [heroku](https://www.heroku.com/) for instance). `rvmpow` will not change the gemfile if ruby and gemset information is present. I advise to remove it prior to running `rvmpow`. If you use one of the other metioned methods, move or delete the files prior to running `rvmpow`.

## Examples

### Rails

```
~/Documents/Dev/Rails  ∆2.1.1 ›rails
13:34 $ rvm-prompt
ruby-2.1.1@rails
~/Documents/Dev/Rails  ∆2.1.1 ›rails
13:34 $ rails new newApp
...
13:35 $ cd newApp/
~/Documents/Dev/Rails/newApp  ∆2.1.1 ›rails
13:35 $ rvmpow init
        Done  Create .powenv file
        Done  Create pow link
        Done  Touch restart file
        Done  Add .powenv to .gitignore
        Done  Add ruby and gemset info to Gemfile
~/Documents/Dev/Rails/newApp  ∆2.1.1 ›rails
13:35 $ rvmpow clear
        Done  Remove rvmpow entries from .gitignore
        Done  Remove rvmpow entries from Gemfile
        Done  Delete .powenv file
        Done  Delete restart file
        Done  Delete pow link
~/Documents/Dev/Rails/newApp  ∆2.1.1 ›rails
```

### Sinatra

Minimal but working. ([source](http://rubylearning.com/blog/a-quick-introduction-to-rack/))

Create a directory for your Sinatra app and do:

```
bundle init
```

Edit the Gemfile as follows:

```ruby
source "https://rubygems.org"

  gem "sinatra"
  gem "rvmpow"
```

Back in the shell, run:

```
bundle install
```

Add the "*app*" file *my_sinatra.rb* :

```ruby
require 'sinatra'

get '/' do
  'Welcome to Sinatra'
end
```

Add the *config.ru* file:

```ruby
require './my_sinatra'
run Sinatra::Application
```

And let `rvmpow` do the rest:

```
~/Documents/Dev/Ruby/frank  ∆2.1.1 ›sinatra
15:01 $ rvm-prompt
ruby-2.1.1@sinatra
~/Documents/Dev/Ruby/frank  ∆2.1.1 ›sinatra
15:01 $ rvmpow init --rackdev --show
        Done  Add .powenv file
        Done  Add app link in ~/.pow
        Done  Touch restart.txt file in ./tmp/
        Done  Add '.powenv' to ./.gitignore
        Done  Add rvm ruby and gemset information to ./Gemfile
        Done  Touch always_restart.txt file in ./tmp/
        Done  Open app in default browser
~/Documents/Dev/Ruby/frank  ∆2.1.1 ›sinatra
```

### Rack

Minimal but working. ([source](http://rubylearning.com/blog/a-quick-introduction-to-rack/))

Create a new directory for your Rack "*app*" with your app file *my_app.rb*:

```ruby
class MyApp
  def call env
    [200, {"Content-Type" => "text/plain"}, ["Hi there!!! The time is #{Time.now}"]]
  end
end
```

Create *config.ru* to launch your app.

```ruby
require './my_app'
run MyApp.new
```

Then let rvmpow do the rest.

```
~/Documents/Dev/Ruby/Rack  ∆2.1.1 ›rack
12:18 $ rvm-prompt
ruby-2.1.1@rack
~/Documents/Dev/Ruby/Rack  ∆2.1.1 ›rails
12:18 $ rvmpow init --rackdev --show
        Done  Add .powenv file
        Done  Add app link in ~/.pow
        Done  Touch restart.txt file in ./tmp/
        Done  Add '.powenv' to ./.gitignore
        Done  Add rvm ruby and gemset information to ./Gemfile
        Done  Touch always_restart.txt file in ./tmp/
        Done  Open app in default browser
~/Documents/Dev/Ruby/Rack  ∆2.1.1 ›rails
```

## Installation

Add this line to your application's Gemfile:

```
gem 'rvmpow'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install rvmpow
```

## Usage

Make sure you are in the root directory of your Rack app before running `rvmpow`

```
$ rvmpow init
```

To open the app in your default browser directly after initialization, run:


```
$ rvmpow init --show
```

To open the app after initialization, run:

```
$ rvmpow open
```

If needed, you can pick individual actions via `rvmpow add` or `rvmpow remove`.

rvmpow comes with extensive help built in, just run:

```
$ rvmpow
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/rvmpow/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
