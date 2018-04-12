require 'rubygems'
require 'bundler/setup'

Bundler.require

account_name = ARGV[0]
api = Radiator::Api.new
query = {tag: account_name, limit: 5}
created = nil

api.get_discussions_by_blog(query) do |posts|
  posts.each do |post|
    words = post.body.split(/\s/)
    author = post.author
    type = author == account_name ? 'Post' : 'Reblog'
    uri = []

    uri << post.parent_permlink
    uri << "@#{author}"
    uri << post.permlink

    if created != post.created
      puts created = Time.parse(post.created + 'Z')
    end

    puts "  #{type}: #{post.title}"
    puts "  By: #{author}"
    puts "  Words: #{words.size}"
    puts "  https://steemit.com/#{uri.join('/')}"
  end
end
