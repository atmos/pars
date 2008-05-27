Treetop.load File.dirname(__FILE__) + '/lvm_backup/lvm_backup_file_you_shouldnt_use'
require File.dirname(__FILE__) + '/lvm_backup/lvm_backup_file_you_shouldnt_use_node_classes'

module Pars
  module LvmBackup
    # override the LvmBackupFileYouShouldntUseParser class by defining a namespaced one
    class Parser < Treetop::Runtime::CompiledParser
      include LvmBackupFileYouShouldntUse
    end
  end
end