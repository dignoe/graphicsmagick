require 'tempfile'
# require 'graphicsmagick/mogrify'
require 'graphicsmagick/processors/identify.rb'

module GraphicsMagick
	class Image
		attr_accessor :file

		# include GraphicsMagick::Mogrify
		include GraphicsMagick::Identify

    # Class Methods
    class << self
    	
    end

    def initialize(input)
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
	end
end