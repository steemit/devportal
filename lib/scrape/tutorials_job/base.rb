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
        tutorial_title_prefix = @tutorial_github_name.split('-').last.upcase
        
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
              title: '#{tutorial_title_prefix}: #{title}'
              position: #{num}
              description: #{description}
              layout: full
              ---              
              #{tutorial_repo_links title, include_name, tutorial_title_prefix}
              <br>

              #{rewrite_relative_links(rewrite_images body, include_name)}
              ---
              
              
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
            description ||= "\"#{line.strip}\""
            
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
      
      def rewrite_relative_links(body)
        body = body.gsub(/\[([^\]]+)\]\(([^)]+)\)/) do
          text, href = Regexp.last_match[1..2]
          href = if href.include? '://'
            href
          elsif href.include? @tutorial_url
            relative_href = href.gsub(/#{@tutorial_url}\/tree\/master\/tutorials\/(\d+)_([a-z0-9_]+)/) do
              num, name = Regexp.last_match[1..2]
              
              name
            end
            
            relative_href
          else
            relative_href = href.gsub(/..\/(\d+)_([a-z0-9_]+)/) do
              num, name = Regexp.last_match[1..2]
              
              name
            end
            
            relative_href
          end
          
          "[#{text}](#{href})"
        end
        
        body
      end
      
      def tutorial_repo_links(title, include_name, tutorial_title_prefix)
          "<span class=\"fa-pull-left top-of-tutorial-repo-link\"><span class=\"first-word\">Full</span>, runnable src of [#{title}](#{@tutorial_url}/tree/master/tutorials/#{include_name}) can be downloaded as part of the [#{tutorial_title_prefix} tutorials repository](#{@tutorial_url}).</span>"
      end
      
      def clean_previous_clone
        FileUtils.rm_rf(Dir.glob("#{TMP_CHECKOUT}/*"))
      end
    end
  end
end
