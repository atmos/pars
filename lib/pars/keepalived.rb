Treetop.load File.dirname(__FILE__) + '/keepalived/keepalived_config_file_you_shouldnt_use'
require File.dirname(__FILE__) + '/keepalived/keepalived_config_file_you_shouldnt_use_node_classes'
module Pars
  module KeepAlived
    class Parser < Treetop::Runtime::CompiledParser
      include KeepAlivedConfigFileYouShouldntUse
    end
  end
end

