require 'rubygems'
require 'bundler/setup'

Bundler.require

# change to true if you want to broadcast this example
broadcast = false
wif = '5JrvPrQeBBvCRdjv29iDvkwn3EQYZ9jqfAHzrCyUvfbEbRkrYFC'
author = 'social'
title = 'title of my post'
permlink = title.gsub(' ', '-').downcase
api = Radiator::Api.new
content = api.get_content(author, permlink).result
metadata = {tags: %w(tag), app: 'devportal/1.0'}
new_body = "#{content.body}\nAppended content."
dmp = DiffMatchPatch.new
patches = dmp.patch_make content.body, new_body
diff_body = dmp.patch_toText(patches)

new_body = diff_body if diff_body < content.body
  
puts "Changes:"
puts new_body

post = {
  type: :comment,
  parent_author: '',
  parent_permlink: metadata[:tags][0],
  author: author,
  permlink: permlink,
  json_metadata: metadata.to_json,
  title: title,
  body: new_body
}

tx = Radiator::Transaction.new(wif: wif)

tx.operations << post
response = tx.process(broadcast)

if broadcast
  if !!response.error
    puts response.error.message
  else
    puts JSON.pretty_generate response
  end
else
  puts 'Not broadcasted.'
end
