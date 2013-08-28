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

		DEFAULT_UTILITY = "mogrify"

		def current_utility
			@utility || DEFAULT_UTILITY
		end

		def to_cmd
			"gm " + build_command('output_file')
		end

		private

		def requires_output_file?
			send(:"#{current_utility}_requires_output_file?")
		end

		def build_command(file)
			send(:"build_#{current_utility}_command", file)
		end

		def options_to_str(opts)
			if opts.nil?
				""
			else
				opts.collect {|opt| "#{opt[:name]} #{opt[:args]}"}.join(" ")
			end
		end

	end
end