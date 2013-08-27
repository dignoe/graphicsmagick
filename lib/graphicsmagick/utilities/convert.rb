module GraphicsMagick
	module Utilities
		module Convert
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