$TESTING=true
$:.push File.join(File.dirname(__FILE__), "..", "lib")

require File.dirname(__FILE__) + "/../lib/pars"

require "test/unit"
require "rubygems"
require "spec"
require "pp"

def fixture(file_name)
  File.read("#{File.dirname(__FILE__)}/fixtures/#{file_name}")
end