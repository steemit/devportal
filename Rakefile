lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'scrape/api_definitions_job'

require 'rake/testtask'
require 'net/https'
require 'json'
require 'yaml'

namespace :scrape do
  desc "Scrape steemjs docs"
  task :javascript do

  end

  desc "Scrape pysteem docs"
  task :python do
  end
  
  desc "Scrape API Definitions"
  task :api_defs do
    job = Scrape::ApiDefinitionsJob.new
    count = job.perform
    
    puts "Methods added or changed: #{count}"
  end
end
