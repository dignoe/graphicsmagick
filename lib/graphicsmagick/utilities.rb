require 'graphicsmagick/utilities/mogrify'
require 'graphicsmagick/utilities/identify'
require 'graphicsmagick/utilities/convert'
require 'graphicsmagick/utilities/composite'

module GraphicsMagick
	module Utilities
		include GraphicsMagick::Utilities::Identify
		include GraphicsMagick::Utilities::Convert
		include GraphicsMagick::Utilities::Composite
		include GraphicsMagick::Utilities::Mogrify

		private

		def options_to_str(opts)
			opts.collect {|opt| "#{opt[:name]} #{opt[:args]}"}.join(" ")
		end

	end
end