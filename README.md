# Bumbleworks::Api

A rack-based web API (using [Rory](http://github.com/screamingmuse/rory)) for your [Bumbleworks](http://github.com/bumbleworks/bumbleworks) instance.

## Installation

Add this line to your application's Gemfile:

    gem 'bumbleworks-api'

## Usage

There are quite a few ways to use this - the most common, if you're using Bumbleworks in a Rails app, would probably be to mount Bumbleworks::Api::RackApp at some path in your Rails routing - see the [Rails routing guide](http://guides.rubyonrails.org/routing.html#routing-to-rack-applications) for more info.

Or you can run it standalone using a Rack server - basically, Bumbleworks just needs to be configured, and then you can `run Bumbleworks::Api::RackApp`.

Note that you can also use [bumbleworks-gui](http://github.com/bumbleworks/bumbleworks-gui), which wraps this API in a simple GUI.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
