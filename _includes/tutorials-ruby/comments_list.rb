require 'rubygems'
require 'bundler/setup'

Bundler.require

url = ARGV[0]
slug = url.split('@').last
author, permlink = slug.split('/')
api = Radiator::TagApi.new

api.get_content_replies(author, permlink) do |replies|
  reply_authors = replies.map{|reply| reply.author}
  reply_authors = reply_authors.uniq.join("\n\t")
  puts "Replies by:\n\t#{reply_authors}"
  puts "Total replies: #{replies.size}"
end
