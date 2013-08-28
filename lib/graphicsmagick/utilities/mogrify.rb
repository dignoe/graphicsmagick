module GraphicsMagick
	module Utilities
		module Mogrify

			private

			def mogrify_requires_output_file?
				false
			end

			# gm mogrify [options] file
			def build_mogrify_command(file_path)
				"mogrify #{options_to_str(@command_options)} #{file_path}"
			end
		end
	end
end