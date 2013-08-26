module GraphicsMagick
	module Utilities
		module Identify
			def identify
				p `gm identify #{path}`
			end
		end
	end
end