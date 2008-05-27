require 'xmlsimple'

module Pars
  module Monit
    class Parser
      attr_reader :filename

      def parse(file)
        @filename = file
        result = ::XmlSimple.xml_in File.open(@filename).read, {'KeepRoot' => true}
        Result.new(result)
      end
    end
    
    class Result
      attr_reader :data
      def initialize(data)
        @data = data
      end
      
      def services
        @data['monit'].first['service'].first
      end
    end
  end
end