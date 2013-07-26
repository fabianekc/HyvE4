# This file is used by Rack-based servers to start the application.
require ::File.expand_path('../config/environment',  __FILE__)

$stdout.sync = true

use Rack::ReverseProxy do
  reverse_proxy(/^\/blog(\/.*)$/, 'http://still-taiga-5256.herokuapp.com$1', opts = {:preserve_host => true})
  reverse_proxy(/^\/bitstarter(\/.*)$/, 'http://fabianekc-bitstarter-mooc.herokuapp.com$1', opts = {:preserve_host => true})
end

run Hyve4::Application
