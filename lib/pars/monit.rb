require 'xmlsimple'

module Pars
  module Monit
    class Parser

      def parse(string)
        result = ::XmlSimple.xml_in string, {'KeepRoot' => true}
        ParseResult.new(result)
      end
    end
  end
end

require File.dirname(__FILE__) + '/monit/parser'
require File.dirname(__FILE__) + '/monit/parse_result'
require File.dirname(__FILE__) + '/monit/service'
require File.dirname(__FILE__) + '/monit/services'
