module Pars
  module Monit
    class Services
      attr_reader :svcs
      def initialize(svcs)
        @svcs = { }
        svcs.each do |svc|
          service = Service.new(svc)
          @svcs.merge!(service.name.to_sym => service)
        end
      end
      
      def names
        svcs.keys.sort { |a,b| a.to_s <=> b.to_s }
      end
      
      def [](key)
         @svcs[key.to_sym]
      end
    end
  end
end
