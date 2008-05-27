module Pars
  module Monit
    class ParseResult
      attr_reader :data
      def initialize(data)
        @data = data
      end
      
      def services
        @services ||= Services.new(@data['monit'].first['service'])
      end
    end
  end
end