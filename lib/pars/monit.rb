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