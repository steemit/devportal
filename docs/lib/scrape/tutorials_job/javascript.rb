require 'git'

module Scrape
  module TutorialsJob
    class Javascript < Base
      def initialize(options = {})
        options[:tutorial_github_url] ||= 'https://github.com/steemit/devportal-tutorials-js.git'
        options[:tutorial_github_name] ||= 'devportal-tutorials-js'
        options[:tutorial_url] = 'https://github.com/steemit/devportal-tutorials-js'
        options[:dest_tutorials_path] ||= '_tutorials-javascript'
        
        super
      end
    end
  end
end
