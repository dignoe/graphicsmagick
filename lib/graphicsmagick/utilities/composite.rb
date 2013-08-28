module GraphicsMagick
	module Utilities
		module Composite

			def composite(base, mask=nil)
				if @utility.nil?
					@utility = "composite"
					@base_file = parse_input(base)
					@mask_file = parse_input(mask) if mask
				else
					raise NoMethodError, "You can't use Image#composite with #{@utility}"
				end
				self
			end


			private

			def composite_requires_output_file?
				false
			end

			# gm convert [options] change-path base-path mask-path output-path
			def build_composite_command(output_path)
  			"composite #{options_to_str(@command_options)} #{path} #{@base_file.path} #{@mask_file.path if @mask_file} #{output_path}"
			end

		end
	end
end