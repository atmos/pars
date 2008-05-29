module KeepAlivedConfigFile
  module AST
    class VrrpSyncGroup
      attr_accessor :group_name, :group, :contents, :notify_backup, :notify_master
      def initialize(group_name, contents)
        @group_name = group_name
        @group = contents[:group].keys
        @contents = contents
        @notify_backup = contents.delete(:notify_backup)
        @notify_master = contents.delete(:notify_master)
      end
    end
  end
end