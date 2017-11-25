
require 'rest-client'
require 'json'

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



