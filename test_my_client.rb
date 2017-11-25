
require './my_client'
require 'minitest/autorun'
require "minitest/reporters"
#Minitest::Reporters.use!
Minitest::Reporters.use! [Minitest::Reporters::HtmlReporter.new , Minitest::Reporters::RubyMineReporter.new]



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
