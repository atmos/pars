Treetop.load File.dirname(__FILE__) + '/lvm_backup/lvm_backup_file_you_shouldnt_use'
require File.dirname(__FILE__) + '/lvm_backup/lvm_backup_node_classes'

module Pars
  module LvmBackup
    class Parser < Treetop::Runtime::CompiledParser
      include LvmBackupFileYouShouldntUse
    end
  end
end