module GraphicsMagick
	module Utilities
		module Identify
			def convert
				if utility == "mogrify"
					utility = "convert"
					options = [options]
				else
					raise NoMethodError, "You can't use Image#convert with #{utility}"
				end
			end

		end
	end
end