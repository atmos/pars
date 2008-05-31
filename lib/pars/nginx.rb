# require File.dirname(__FILE__) + '/nginx/ast'
Treetop.load File.dirname(__FILE__) + '/nginx/nginx_config_file_you_shouldnt_use'
require File.dirname(__FILE__) + '/nginx/nginx_config_file_you_shouldnt_use_node_classes'

module Pars
  module Nginx
    class Parser < Treetop::Runtime::CompiledParser
      include NginxConfigFileYouShouldntUse
    end
  end
end

