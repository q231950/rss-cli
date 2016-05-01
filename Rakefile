require 'rake/testtask'
require 'rspec/core/rake_task'
require 'rdoc/task'

Rake::TestTask.new do |t|
  t.libs << "tests"
  t.test_files = FileList['tests/test*.rb']
  t.verbose = false
  t.warning = false
end

RSpec::Core::RakeTask.new(:spec)

RDoc::Task.new() do |rdoc|
  rdoc.title = "RSS cli"
  rdoc.main = "rss-cli.rb"
  rdoc.rdoc_files.include("README.md", "Rakefile", "lib/*.rb")
  rdoc.options << '-f' << 'hanna'
end
