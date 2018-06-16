require 'git'

module Scrape
  module TutorialsJob
    class Ruby < Base
      def initialize(options = {})
        # FIXME Need to make the repo public (workaround as follows).
        # options[:tutorial_github_url] = 'https://github.com/steemit/devportal-tutorials-rb.git'
        options[:tutorial_github_url] ||= 'git@github.com:steemit/devportal-tutorials-rb.git'
        options[:tutorial_github_name] ||= 'devportal-tutorials-rb'
        options[:tutorial_url] = 'https://github.com/steemit/devportal-tutorials-rb'
        options[:dest_tutorials_path] ||= '_tutorials-ruby'
        
        super
      end
    end
  end
end
