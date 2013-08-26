require 'tempfile'

module Graphicsmagick
	class Image
		attr_accessor :file

    # Class Methods
    class << self
    	
    end

    def initialize(input)
    	if input.is_a? String
    		self.file = File.new(input)
    	elsif input.is_a? File || input.is_a? Tempfile
    		self.file = input
    	else
    		raise TypeError, "You must specify an input file as a String or File object"
    	end
  	end

  	def path
  		file.path
  	end
	end
end