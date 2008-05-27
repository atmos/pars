Gem::Specification.new do |s|
  s.name = %q{pars}
  s.version = "0.0.1"

  s.specification_version = 2 if s.respond_to? :specification_version=

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Corey Donohoe"]
  s.autorequire = %q{pars}
  s.date = %q{2008-05-26}
  s.description = %q{A gem that provides parse routines for various linux config file formats}
  s.email = %q{cdonohoe@engineyard.com}
  s.extra_rdoc_files = ["README", "LICENSE", "TODO"]
  s.files = ["LICENSE", "README", "Rakefile", "TODO", "lib/pars", "lib/pars/evaluator.rb", "lib/pars/lvm_backup", "lib/pars/lvm_backup/lvm_backup.treetop", "lib/pars/lvm_backup/lvm_backup_node_classes.rb", "lib/pars/lvm_backup.rb", "lib/pars/xm", "lib/pars/xm/info.rb", "lib/pars/xm/list.rb", "lib/pars/xm/xenstore_ls.rb", "lib/pars/xm.rb", "lib/pars.rb", "spec/evaluator_spec.rb", "spec/fixtures", "spec/fixtures/keepalived", "spec/fixtures/keepalived/keepalived.conf", "spec/fixtures/lvm_backups", "spec/fixtures/lvm_backups/ey04-data00", "spec/fixtures/lvm_backups/ey04-data01", "spec/fixtures/lvm_backups/ey04-data02", "spec/fixtures/lvm_backups/ey04-data03", "spec/fixtures/lvm_backups/ey04-data04", "spec/fixtures/lvm_backups/ey04-data05", "spec/fixtures/lvm_backups/ey04-n00-local", "spec/fixtures/xm", "spec/fixtures/xm/info", "spec/fixtures/xm/info/ey00n00.xm.info.txt", "spec/fixtures/xm/list", "spec/fixtures/xm/list/ey00n00.xm.list.txt", "spec/fixtures/xm/xenstore-ls", "spec/fixtures/xm/xenstore-ls/xenstore_ls_output.txt", "spec/integration", "spec/integration/lvm_backup_spec.rb", "spec/lvm_backups", "spec/lvm_backups/array_assignment_spec.rb", "spec/lvm_backups/blocks_spec.rb", "spec/lvm_backups/integer_assignment_spec.rb", "spec/lvm_backups/multiline_spec.rb", "spec/lvm_backups/string_assignment.rb", "spec/lvm_backups/string_literal_spec.rb", "spec/pars_spec.rb", "spec/spec_helper.rb", "spec/xm", "spec/xm/info_spec.rb", "spec/xm/list_spec.rb", "spec/xm/xenstore_ls_spec.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/atmos/pars/tree/master}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.1.1}
  s.summary = %q{A gem that provides parse routines for various linux config file formats}

  s.add_dependency(%q<treetop>, [">= 0"])
end
