module GraphicsMagick
	module Identify
		def identify
			p `gm identify #{path}`
		end
	end
end