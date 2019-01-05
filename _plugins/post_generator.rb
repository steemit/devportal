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
        content.body + <<~DONE
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
