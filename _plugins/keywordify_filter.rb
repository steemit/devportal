module Jekyll
  module KeywordifyFilter
    SEP = /[^a-z0-9]+/i
    STOP_WORDS = %w(i me my myself we our ours ourselves you your yours yourself
      yourselves he him his himself she her hers herself it its itself they them
      their theirs themselves what which who whom this that these those am is
      are was were be been being have has had having do does did doing a an the
      and but if or because as until while of at by for with about against
      between into through during before after above below to from up down in
      out on off over under again further then once here there when where why
      how all any both each few more most other some such no nor not only own
      same so than too very s t can will just don should now)
    
    def keywordify(object, mode = 'subtract', extra_keywords = nil)
      output = []
    
      case object
      when Hash
        object.each do |k, v|
          output += keywordify(k).split(SEP)
          output += keywordify(v).split(SEP)
        end
      when Array
        object.each do |k, v|
          output += keywordify(v).split(SEP)
        end
      when NilClass
        # no-op
      else
        output += object.inspect.split(SEP)
      end
      
      output = output.map(&:strip).map(&:downcase)
      extra_keywords = extra_keywords.to_s.split(SEP).map(&:strip).map(&:downcase)
      
      case mode
      when 'subtract' then output -= extra_keywords
      when 'add' then output += extra_keywords
      else; raise "Unknown mode: #{mode}"
      end
      
      (output - STOP_WORDS).uniq.compact.join(' ').strip
    end
  end
end

Liquid::Template.register_filter(Jekyll::KeywordifyFilter)

# USAGE:
# {{object | keywordify}}
# {{object | keywordify 'subtract', 'some words to subtract'}}
# {{object | keywordify 'add', 'additional words to add'}}
