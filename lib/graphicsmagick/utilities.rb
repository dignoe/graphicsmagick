require 'graphicsmagick/utilities/mogrify'
require 'graphicsmagick/utilities/identify'

module GraphicsMagick
	module Utilities
		include GraphicsMagick::Utilities::Identify

		attr_accessor :utility

		def convert
			@utility = "convert"
		end

		private

		def utility
			@utility ||= "mogrify"
		end
	end
end