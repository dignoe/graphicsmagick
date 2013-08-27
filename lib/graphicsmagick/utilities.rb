require 'graphicsmagick/utilities/mogrify'
require 'graphicsmagick/utilities/identify'
require 'graphicsmagick/utilities/convert'

module GraphicsMagick
	module Utilities
		include GraphicsMagick::Utilities::Identify
		include GraphicsMagick::Utilities::Convert


	end
end