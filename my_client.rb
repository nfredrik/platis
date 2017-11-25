
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
      2
  end

end



if __FILE__ == $PROGRAM_NAME

require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!


  class Test_MyClient  < Minitest::Test

  	def setup

  		  @client = MyClient.new     
    end

  	def test_login
  		VCR.use_cassette("mimgao") do
   		@response = @client.get('http://example.com')
   	    end
   		refute_nil @response
  	end


    def test_failing_500
      VCR.use_cassette("error500") do
      @response = @client.get('https://httpstat.us/500')
        end
      refute_nil @response
    end

    def test_foaas
    end
   

  end


end