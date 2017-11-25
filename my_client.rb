
require 'rest-client'
require 'json'
require 'vcr'
require 'webmock'

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/example"
  config.hook_into :webmock
end


class MyClient 

  def initialize
  	@client = RestClient
  end

  def method_missing(method, *args, &block)

    if RestClient.public_methods.include?(method.to_sym)
    	resp = RestClient.send(method, *args, &block)
        resp.body
    else
    	super
    end
     
    rescue => e
      puts 'got problem!!'
      puts e
      2
  end

end



