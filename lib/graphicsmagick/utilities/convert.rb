module GraphicsMagick
	module Utilities
		module Convert
			def convert
				if @utility.nil?
					@utility = "convert"
					@command_options = [command_options]
				else
					raise NoMethodError, "You can't use Image#convert with #{utility}"
				end
			end

			private

			# gm convert [options] input-path [options] output-path
			def build_convert_command(output_path)
  			first_options = @command_options.shift
  			"convert #{options_to_str(first_options)} #{path} #{options_to_str(@command_options)} #{output_path}"
			end

		end
	end
end