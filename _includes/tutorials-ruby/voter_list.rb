require 'rubygems'
require 'bundler/setup'

Bundler.require

url = ARGV[0]
slug = url.split('@').last
author, permlink = slug.split('/')
api = Radiator::Api.new

api.get_active_votes(author, permlink) do |votes|
  upvotes = votes.select { |v| v.percent > 0 }.size
  downvotes = votes.select { |v| v.percent < 0 }.size
  unvotes = votes.select { |v| v.percent == 0 }.size
  top_voter = votes.sort_by { |v| v.rshares.to_i }.last.voter
  
  puts "Upvotes: #{upvotes}"
  puts "Downvotes: #{downvotes}"
  puts "Unvotes: #{unvotes}"
  puts "Total: #{votes.size}"
  puts "Top Voter: #{top_voter}"
end
