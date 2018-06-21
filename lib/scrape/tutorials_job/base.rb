require 'git'

module Scrape
  module TutorialsJob
    class Base
      TMP_CHECKOUT = '/tmp/checkout'
      
      def initialize(options = {})
        @num = (options[:num] || '-1').to_i
        @force = options[:force] == 'true'
        @tutorial_github_url = options[:tutorial_github_url] #e.g.: https://github.com/steemit/devportal-tutorials-js.git
        @tutorial_github_name = options[:tutorial_github_name] # e.g.: devportal-tutorials-js
        @tutorial_url = options[:tutorial_url] # e.g.: https://github.com/steemit/devportal-tutorials-js
        @dest_tutorials_path = options[:dest_tutorials_path] # e.g.: _tutorials-javascript
        
        @clone_tutorials_path = "#{TMP_CHECKOUT}/#{@tutorial_github_name}/tutorials"
      end
      
      # Execute the job.
      #
      # @return [Integer] total number of tutorials added or changed in this pass
      def perform
        tutorial_change_count = 0
        
        clean_previous_clone
        
        Git.clone(@tutorial_github_url, @tutorial_github_name, path: TMP_CHECKOUT)
        
        Pathname.new(@clone_tutorials_path).children.sort.each do |path|
          next unless File.directory? path
          
          slug = include_name = path.to_s.split('/').last
          slug = slug.split('_')
          num = slug[0].to_i
          
          next if @num != -1 && @num != num
          
          name = slug[1..-1].join '_'
          title = slug[1..-1].map(&:capitalize).join ' '
          readme = "#{path}/README.md"
          destination = "#{@dest_tutorials_path}/#{name}.md"
          
          if File.exists?(destination) && @force
            puts "##{num}: \"#{title}\" already exists.  Forcing."
          elsif File.exists? destination
            puts "##{num}: \"#{title}\" already exists.  Skipping."
            next
          end
          
          parse_readme(readme) do |description, body|
            template = <<~DONE
              ---
              title: #{title}
              position: #{num}
              description: #{description}
              layout: full
              ---
              #{rewrite_images body, include_name}
            DONE
            
            f = File.open(destination, 'w+')
            f.puts template.strip + "\n"
            f.close
          end
          
          tutorial_change_count += 1
        end
        
        clean_previous_clone
        
        tutorial_change_count
      end
    private
      def parse_readme(readme)
        description = nil
        body = ''
        
        File.open(readme, 'r').each_line do |line|
          next if line =~ /^# /
          
          if description.nil? && !line.strip.empty?
            description ||= line.gsub(/[^a-zA-Z0-9 ]/, '').strip
            
            next
          end
          
          body << line
        end
        
        yield description, body
      end
      
      def rewrite_images(body, include_name)
        body = body.gsub(/!\[([^\]]+)\]\(([^)]+)\)/) do
          alt, src = Regexp.last_match[1..2]
          src = if src.include? '://'
            src
          else
            src = src.split('/')[1..-1].join('/') if src.start_with? './'
            "#{@tutorial_url}/blob/master/tutorials/#{include_name}/#{src}?raw=true"
          end
          
          "![#{alt}](#{src})"
        end
        
        body
      end
      
      def clean_previous_clone
        FileUtils.rm_rf(Dir.glob("#{TMP_CHECKOUT}/*"))
      end
    end
  end
end
