module GraphicsMagick
	module Utilities
		module Convert
			def convert
				if @utility.nil?
					@utility = "convert"
					@command_options = [@command_options]
				else
					raise NoMethodError, "You can't use Image#convert with #{@utility}"
				end
				self
			end

			private

			def convert_requires_output_file?
				true
			end

			# gm convert [options] input-path [options] output-path
			def build_convert_command(output_path)
  			first_options = @command_options[0]
  			second_options = @command_options[1..@command_options.length]
  			"convert #{options_to_str(first_options)} #{path} #{options_to_str(second_options)} #{output_path}"
			end

		end
	end
end