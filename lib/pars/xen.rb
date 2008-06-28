require File.dirname(__FILE__) + '/xen/ast'
Treetop.load File.dirname(__FILE__) + '/xen/xen_config_file_you_shouldnt_use'
require File.dirname(__FILE__) + '/xen/xen_config_file_you_shouldnt_use_node_classes'

module Pars
  module Xen
    class Parser < Treetop::Runtime::CompiledParser
      include XenConfigFileYouShouldntUse
    end
  end
end

