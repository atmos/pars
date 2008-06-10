require 'xmlsimple'

module Pars
  module Monit
    class Parser
      attr_reader :filename

      def parse(file)
        @filename = file
        result = ::XmlSimple.xml_in @filename, {'KeepRoot' => true}
        ParseResult.new(result)
      end
    end
  end
end