module XenConfigFile
  module AST
    class Comment
      attr_reader :contents
      def initialize(contents)
        @contents = contents
      end
    end
  end
end