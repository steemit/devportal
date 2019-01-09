require 'steem'

module Jekyll
  module SteemPostGenerator
    def steem_post(slug)
      slug = slug.split('@').last
      slug = slug.split('/')
      author = slug[0]
      permlink = slug[1..-1].join('/')
      permlink = permlink.split('?').first
      permlink = permlink.split('#').first
      api = Steem::CondenserApi.new
      
      api.get_content(author, permlink) do |content|
        body = content.body
        
        # This will normalize image hoster proxy URLs that the author copied
        # from another post.
        
        body = body.gsub(/https:\/\/steemitimages.com\/[0-9]+x0\/https:\/\//, 'https://')
        
        # Although it works on steemit.com and many other markdown interpretors,
        # kramdown doesn't like this, so we have to fix it:
        # 
        # <div>
        #   This *won't* work.
        # </div>
        #
        # See: https://stackoverflow.blog/2008/06/25/three-markdown-gotcha/
        
        body = body.gsub(/<([^\/].+)>(.+)<\/\1>/m) do
          match = Regexp.last_match
          html = Kramdown::Document.new(match[2]).to_html
          
          "<#{match[1]}>#{html.gsub("\n", "<br />")}</#{match[1]}>"
        end
        
        body + <<~DONE
        \n<hr />
        <p>
          See: <a href="https://steemit.com/@#{author}/#{permlink}">#{content.title}</a>
          by
          <a href="https://steemit.com/@#{author}">@#{author}</a>
        </p>
        DONE
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::SteemPostGenerator)

# USAGE:
# {{'@stoodkev/how-to-set-up-and-use-multisignature-accounts-on-steem-blockchain' | steem_post}}
