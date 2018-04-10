require 'neatjson'

module Jekyll
  module NeatJsonFilter
    def neat_json(input)
      begin
        JSON.neat_generate(input, wrap: 50, after_comma: 1, after_colon: 1)
      rescue JSON::GeneratorError => e
        "Error: #{e}."
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::NeatJsonFilter)

# USAGE:
# {{ site.data.user | neat_json }}
# 
# neatjson formatting options: https://github.com/Phrogz/NeatJSON#options
