$TESTING=true
$:.push File.join(File.dirname(__FILE__), '..', 'lib')

require File.dirname(__FILE__)+'/../lib/pars'

require 'test/unit'
require 'rubygems'
require 'spec'
require 'pp'

module Spec
  module Helpers
    def fixture_path()
    end
  end
end