module Pars
  module Xm
    class InfoOutput
      attr_reader :filename, :results
      def parse(file)
        @filename = File.expand_path(file)
        @results = YAML.load(File.read(@filename))
      end
    end
  end
end