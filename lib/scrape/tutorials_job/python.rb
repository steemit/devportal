require 'git'

module Scrape
  module TutorialsJob
    class Python < Base
      def initialize(options = {})
        # FIXME Need to make the repo public (workaround as follows).
        # options[:tutorial_github_url] = 'https://github.com/steemit/devportal-tutorials-py.git'
        options[:tutorial_github_url] ||= 'git@github.com:steemit/devportal-tutorials-py.git'
        options[:tutorial_github_name] ||= 'devportal-tutorials-py'
        options[:tutorial_url] = 'https://github.com/steemit/devportal-tutorials-py'
        options[:dest_tutorials_path] ||= '_tutorials-python'
        
        super
      end
    end
  end
end
