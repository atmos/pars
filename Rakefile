require 'rubygems'
require 'rake/gempackagetask'
require 'rubygems/specification'
require 'spec'
require 'spec/rake/spectask'
require 'date'

GEM = "pars"
GEM_VERSION = "0.0.1"
AUTHOR = "Corey Donohoe"
EMAIL = "cdonohoe@engineyard.com"
HOMEPAGE = "http://github.com/atmos/pars/tree/master"
SUMMARY = "A gem that provides parse routines for various linux config file formats"

spec = Gem::Specification.new do |s|
  s.name = GEM
  s.version = GEM_VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["README", "LICENSE", 'TODO']
  s.summary = SUMMARY
  s.description = s.summary
  s.author = AUTHOR
  s.email = EMAIL
  s.homepage = HOMEPAGE
  
  # Uncomment this to add a dependency
  s.add_dependency "treetop"
  
  s.require_path = 'lib'
  s.autorequire = GEM
  s.files = %w(LICENSE README Rakefile TODO) + Dir.glob("{lib,spec}/**/**/*")
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
  FileUtils.cp "README.markdown", "README"
end

desc "install the gem locally"
task :install => [:package] do
  sh %{sudo gem install pkg/#{GEM}-#{GEM_VERSION}}
end

desc "create a gemspec file"
task :make_spec do
  File.open("#{GEM}.gemspec", "w") do |file|
    file.puts spec.to_ruby
  end
end
task :default => ['spec:run']
ENV['SLOW_TESTS_TOO'] == true

task :readme do
  require 'bluecloth'
  FileUtils.mkdir_p File.dirname(__FILE__)+'/doc'
  File.open("doc/README.html", 'w') do |outfp|
    File.open("README.markdown") do |infp|
      outfp.puts BlueCloth::new(infp.read).to_html
    end
  end
  %x{open #{File.dirname(__FILE__)+'/doc/README.html'}}
end
namespace :spec do
  Spec::Rake::SpecTask.new('run') do |t|
    t.spec_files = FileList['spec/**/**/*.rb']
  end
  
  desc "Generate specdocs for examples for inclusion in RDoc"
  Spec::Rake::SpecTask.new('doc') do |t|
    t.spec_files = FileList['spec/**/**/*.rb']
    t.spec_opts = ["--format", "specdoc"]
  end
end
