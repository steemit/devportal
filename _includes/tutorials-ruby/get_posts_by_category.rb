require 'rubygems'
require 'bundler/setup'

Bundler.require

CATEGORIES = %i(trending hot active created votes promoted children)

if ARGV.size < 1
  puts "Usage:"
  puts "ruby #{__FILE__} <#{CATEGORIES.join('|')}> [limit] [tag]"
  exit
end

category = ARGV[0].downcase.to_sym

unless CATEGORIES.include? category
  puts "Unknown category: #{category}"
  puts "Expecting one of: #{CATEGORIES.join(', ')}"
  exit
end

limit = (ARGV[1] || '10').to_i
tag = ARGV[2] || ''
api = Radiator::Api.new

options = {
  tag: tag,
  limit: limit
}

api.send("get_discussions_by_#{category}", options) do |posts, error|
  if !!error
    puts error.message
    exit
  end
  
  posts.each do |post|
    words = post.body.split(/\s/)
    author = post.author
    promoted = post.promoted
    uri = []

    uri << post.parent_permlink
    uri << "@#{author}"
    uri << post.permlink

    puts created = Time.parse(post.created + 'Z')
    puts "  Post: #{post.title}"
    puts "  By: #{author}"
    puts "  Votes: #{post.net_votes}"
    puts "  Replies: #{post.children}"
    puts "  Promoted: #{promoted}"
    puts "  Words: #{words.size}"
    puts "  https://steemit.com/#{uri.join('/')}"
  end
end
