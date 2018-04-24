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
    sh 'bundle exec jekyll build'
  end
  
  desc "Deploy current master to gh-pages"
  task deploy: [:prevent_dirty_builds, :build] do
    sh 'git checkout gh-pages'
    sh 'git add -A'
    sh 'git commit -m "jekyll base sources"'
    sh 'git push origin gh-pages'
    
    exit(0)
  end
  
  desc "Rollback gh-pages"
  task rollback: [:prevent_dirty_builds] do
    sh 'git checkout gh-pages'
    sh 'git reset --hard HEAD^'
    sh 'git push origin gh-pages'
    
    exit(0)
  end
end
