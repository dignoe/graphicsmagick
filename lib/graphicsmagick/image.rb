require 'tempfile'
require 'subexec'
require 'shellwords'
require 'graphicsmagick/utilities'

module GraphicsMagick

	GraphicsMagickError = Class.new(StandardError)

	class Image
		attr_accessor :file
		attr_accessor :command_options
		attr_accessor :utility

		include GraphicsMagick::Utilities

    def initialize(input)
    	self.command_options = []
    	self.utility = "mogrify"

    	if input.is_a? String
    		self.file = File.new(input)
    	elsif input.is_a?(File) || input.is_a?(Tempfile)
    		self.file = input
    	else
    		raise TypeError, "You must specify an input file as a String or File object"
    	end
  	end

  	def path
  		file.path
  	end

  	def write output
  		output_path = if output.is_a? String
  			output
  		elsif output.is_a?(File) || output.is_a?(Tempfile)
  			output.path
  		else
  			raise TypeError, "You must specify an output file as a String or File object"
    	end

  		command = if utility == "mogrify"
  			# copy file
  			FileUtils.copy_file(path, output_path)

  			# gm mogrify [options] file
  			option_str = command_options.collect {|opt| "#{opt.key} #{opt.value}"}.join(" ")
  			"gm mogrify #{option_str} #{output_path}"

  		elsif utility == "convert"
  			# gm convert [options] input-path [options] output-path
  			options1 = command_options.shift
  			option_str1 = options1.collect {|opt| "#{opt.key} #{opt.value}"}.join(" ")
  			option_str2 = command_options.collect {|opt| "#{opt.key} #{opt.value}"}.join(" ")
  			"gm convert #{option_str1} #{path} #{option_str2} #{output_path}"

  		elsif utility == "composite"
  			# gm convert [options] change-path base-path mask-path output-path
  			option_str = command_options.collect {|opt| "#{opt.key} #{opt.value}"}.join(" ")
  			"gm composite #{option_str} #{path} #{base_path} #{mask_path} #{output_path}"
  		end

  		run(command)
  		output.nil? ? self : GraphicsMagick::Image.new(output_path)
  	end

  	def write!
  		command = if utility == "mogrify"
  			option_str = command_options.collect {|opt| "#{opt.key} #{opt.value}"}.join(" ")
  			"gm mogrify #{option_str} #{path}"
  		else
  			raise NoMethodError, "You must use Image#write(output) with the #{utility} command"
  		end

  		run(command)
  		self
  	end

  	protected

  	def method_missing(method, *args, &block)
      add_option("-#{method.to_s}", *args)
    end

    private

    def add_option option_name, *args
    	option_args = args.collect { |a| Shellwords.escape(a.to_s) }
    	option_args = nil if option_args.is_a?(Array) && option_args.empty?
    	command_options << {option_name => option_args}
    	self
    end

    def run command
    	cmd = Subexec.run(command, :timeout => 30.seconds)

      if cmd.exitstatus != 0
      	raise GraphicsMagickError, "#{command} failed: #{cmd.output}"
      end
    end

	end
end