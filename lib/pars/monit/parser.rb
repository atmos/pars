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
        @services ||= Services.new(@data['monit'].first['service'])
      end
    end
    
    class Services
      attr_reader :svcs
      def initialize(svcs)
        @svcs = svcs
        pp svcs
      end
      def names
        svcs.map { |service| service["name"] }.flatten
      end
      def [](key)
         @svcs.find { |service| service['name'] == key }
      end
    end
    
    class Service
      attr_reader :pid, :status, :name, :memory, :monitor_type, :pendingaction, :cpu, :group, :load
    end
  end
end