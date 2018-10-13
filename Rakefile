require 'rake/testtask'

task default: [:test]

desc 'Run all tests in test'
Rake::TestTask.new do |t|
  t.test_files = FileList['test/*_test.rb']
end

desc 'Run the game!'
task :run do
  ruby 'battleship.rb'
end

desc 'Run the game! (in secret debug mode. shhhhh)'
task :debug do
  ruby 'battleship.rb -debug'
end
