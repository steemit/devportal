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

namespace :production do
  task :prevent_dirty_builds do
    if `git status --porcelain`.chomp.length > 0
      puts '*** WARNING: You currently have uncommitted changes. ***'
      fail 'Build aborted, because project directory is not clean.' unless ENV['ALLOW_DIRTY']
    end
  end
  
  task :build do
    sh 'bundle exec jekyll build --destination docs'
  end
  
  task :drop_previous_build do
    sh 'git checkout master'
    sh 'git rm -rf docs'
    sh 'git commit -m "jekyll dropped previous docs"'
  end
  
  desc "Deploy current master to master"
  task deploy: [:prevent_dirty_builds, :drop_previous_build, :build] do
    sh 'git add -A'
    sh 'git commit -m "jekyll base sources"'
    sh 'git push origin master'
    
    exit(0)
  end
  
  desc "Rollback master"
  task rollback: [:prevent_dirty_builds] do
    sh 'git checkout master'
    sh 'git reset --hard HEAD^2'
    sh 'git push origin master'
    
    exit(0)
  end
end
