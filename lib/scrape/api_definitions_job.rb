module Scrape
  
  # Scrapes all known methods for all known APIs and saves them to as `.yml`.
  class ApiDefinitionsJob
    attr_accessor :url, :api_data_path
    
    DEFAULT_URL = 'https://appbasetest.timcliff.com'
    DEFAULT_API_DATA_PATH = '_data/apidefinitions'
    REQUEST_CONTENT_TYPE = 'application/json; charset=utf-8'
    
    def initialize(options = {url: DEFAULT_URL, api_data_path: DEFAULT_API_DATA_PATH})
      @url = options[:url] || DEFAULT_URL
      @api_data_path = options[:api_data_path] || DEFAULT_API_DATA_PATH
    end
    
    # Execute the job.
    #
    # @return [Integer] total number of methods added or changed in this pass
    def perform
      method_add_count = 0
      
      apis.each do |api, methods|
        file_name = "#{api_data_path}/#{api}.yml"
        puts "Definitions for: #{api}, methods: #{methods.size}"
        
        dirty, yml = if File.exist?(file_name)
          [false, YAML.load_file(file_name)]
        else
          # Initialize
          [true, [
            'name' => api,
            'description' => nil,
            'methods' => []
          ]]
        end
        
        methods.each do |method|
          method_name = "#{api}.#{method}"
          existing_api_method = yml[0]['methods'].reverse.find{|e| e['api_method'] == method_name}
          
          request = Net::HTTP::Post.new(uri.request_uri)
          request.body = {
            jsonrpc: '2.0',
            id: 1,
            method: 'jsonrpc.get_signature',
            params: {method: method_name}
          }.to_json
          request['Content-Type'] = REQUEST_CONTENT_TYPE

          response = http.request(request)

          signature = case response.code
          when '200'
            response = JSON[response.body]
            
            next if !!response['error']
            
            response['result']
          else
            raise response.inspect
          end
          
          if existing_api_method
            parameter_json = signature['args']
            expected_response_json = signature['ret']
            if existing_api_method['parameter_json'] == parameter_json &&
              existing_api_method['expected_response_json'] == expected_response_json
              next
            else
              puts "\tChanged: #{method}"
            end
          else
            puts "\tAdding: #{method}"
          end
          
          dirty = true
          yml[0]['methods'] << {
            'api_method' => method_name,
            'purpose' => nil,
            'parameter_json' => signature['args'],
            'expected_response_json' => signature['ret']
          }
          
          method_add_count += 1
        end
        
        next unless dirty
        
        File.open(file_name, 'w+') do |f|
          f.write yml.to_yaml
        end
      end
      
      method_add_count
    end
  private
    def uri
      @uri ||= URI.parse(url)
    end
    
    def http
      @http ||= Net::HTTP.new(uri.host, uri.port).tap do |http|
        http.use_ssl = true
      end
    end
    
    def apis
      request = Net::HTTP::Post.new(uri.request_uri)
      request.body = {
        jsonrpc: '2.0',
        id: 1,
        method: 'jsonrpc.get_methods',
        params: {}
      }.to_json
      request['Content-Type'] = REQUEST_CONTENT_TYPE
      
      response = http.request(request)
      
      case response.code
      when '200'
        response = JSON[response.body]
        
        if !!response['error']
          puts "Error while trying to make request: #{request.body}"
          puts "#{url} is not an AppBase api endpoint?"
          
          raise response.inspect 
        end
        
        methods = response['result'].map do |method|
          method.split('.').map(&:to_sym)
        end
        
        apis = {}
        
        methods.each do |api, method|
          apis[api] ||= []
          apis[api] << method
        end
      else
        puts "Error while trying to make request: #{request.body}"
        puts "#{url} is not an api endpoint?"
        
        raise response.inspect
      end
      
      apis
    end
  end
end