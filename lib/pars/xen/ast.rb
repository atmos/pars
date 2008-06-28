module XenConfigFile
  module AST
    class ConfigFile
      attr_accessor :disks, :vars, :comments
      def initialize(contents)
        @vars = [ ]
        @comments = contents.delete(:comments)
        disks = contents[:variables].detect { |var| var.lhs == :disk }
        # pp contents
        @disks = Disk.build(contents[:variables].delete(disks))
        
        contents[:variables].each do |var|
          @vars << var
        end
      end
      def [](key)
        @vars.detect { |v| v.lhs == key }.rhs
      end
    end
    
    class Disk
      attr_accessor :volume, :device, :mode
      def self.build(contents)
        contents.rhs.map do |disk|
          volume, device, mode = disk.split(/,/)
          new(volume, device, mode)
        end unless contents.nil?
      end
      def initialize(volume, device, mode)
        @volume, @device, @mode = volume, device, mode
      end
      def to_s; "#{volume},#{device},#{mode}" end
    end
    
    class Assignment
      attr_accessor :lhs, :rhs
      def initialize(lhs, rhs)
        @lhs, @rhs = lhs, rhs
      end
      def to_s
        "#{lhs} = #{rhs}"
      end
    end
    class ArrayAssignment < Assignment
      def to_s
        "TODO"
      end
    end
    
    class LiteralString
      def to_s; "\"#{self}\"" end
    end

    module Visitor
      class Printer
      end
    end
  end
end