require 'rubygems'
require 'bundler/setup'

Bundler.require

options = {
  wif: '5JrvPrQeBBvCRdjv29iDvkwn3EQYZ9jqfAHzrCyUvfbEbRkrYFC'
}
tx = Radiator::Transaction.new(options)

tags = %w(tag1 tag2 tag3)
metadata = {
  tags: tags
}

tx.operations << {
  type: :comment,
  author: 'social',
  permlink: 'test-post',
  parent_author: '',
  parent_permlink: tags[0],
  title: 'Test Post',
  body: 'Body',
  json_metadata: metadata.to_json
}

response = tx.process(true)

if !!response.error
  puts response.error.message
else
  puts JSON.pretty_generate response
end
