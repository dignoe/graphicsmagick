module GraphicsMagick
	module Utilities
		module Identify
			attr_accessor :identity

			def width
				get_identity.strip.split('x')[0]
			end

			def height
				get_identity.strip.split('x')[1]
			end

			private

			def get_identity
				@identity ||= `gm identify -ping -format '%wx%h' #{path}`
			end
		end
	end
end