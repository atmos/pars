module Pars
  module Xm
    class InfoOutput
      attr_reader :filename, :results
      def parse(text)
        @results = YAML.load(text)
      end
    end
  end
end