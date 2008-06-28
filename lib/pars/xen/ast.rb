module XenConfigFile
  module AST
    class ConfigFile
      attr_accessor :disks, :vars, :comments
      def initialize(contents)
        @comments = contents.delete(:comments)
        @disks = Disk.build(contents.delete(:disk))
        @vars = contents.dup
      end
    end
    
    class Disk
      attr_accessor :volume, :device, :mode
      def self.build(contents)
        contents.map do |disk|
          volume, device, mode = disk.split(/,/)
          new(volume, device, mode)
        end unless contents.nil?
      end
      def initialize(volume, device, mode)
        @volume, @device, @mode = volume, device, mode
      end
    end
    
    module Visitor
      class Printer
      end
    end
  end
end