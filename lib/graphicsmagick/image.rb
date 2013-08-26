require 'tempfile'
require 'graphicsmagick/utilities'

module GraphicsMagick
	class Image
		attr_accessor :file
		attr_accessor :current_utility
		attr_accessor :commands

		include GraphicsMagick::Utilities

    # Class Methods
    class << self
    	
    end

    def initialize(input)
    	commands = []
    	current_utility = "mogrify"

    	if input.is_a? String
    		self.file = File.new(input)
    	elsif input.is_a?(File) || input.is_a?(Tempfile)
    		self.file = input
    	else
    		raise TypeError, "You must specify an input file as a String or File object"
    	end
  	end

  	def path
  		file.path
  	end

  	def write output
  		
  	end

  	def write!
  		
  	end
	end
end