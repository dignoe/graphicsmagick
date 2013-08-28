require 'tempfile'
require 'subexec'
require 'shellwords'
require 'graphicsmagick/utilities'
require 'active_support/core_ext/numeric/time'

module GraphicsMagick

	UnknownOptionError = Class.new(StandardError)

	class Image
		attr_reader :file

		include GraphicsMagick::Utilities

    def initialize(input)
    	@command_options = []
    	@utility = nil

    	@file = parse_input(input)
  	end

  	def path
  		@file.path
  	end

  	def write output
  		output_path = parse_input(output, false)

  		FileUtils.copy_file(self.path, output_path) unless requires_output_file?
  		
  		command = build_command(output_path)
  		run(command)
  		GraphicsMagick::Image.new(output_path)
  	end

  	def write!
  		raise NoMethodError, "You cannot use Image#write(output) with the #{current_utility} command" if requires_output_file?

  		command = build_command(path)
  		run(command)
  		self
  	end

  	protected

  	def method_missing(method, *args, &block)
      add_option("-#{method.to_s.gsub(/_/,'-')}", *args)
    end

    private

    def add_option option_name, *args
    	@command_options << {:name => option_name, :args => args.collect { |a| Shellwords.escape(a.to_s) }.join(" ")}
    	self
    end

    def run command
    	command = "gm #{command}"
    	cmd = Subexec.run(command, :timeout => 30.seconds)

      if cmd.exitstatus != 0
      	raise UnknownOptionError, "#{command} failed: #{cmd.output}"
      end
    ensure
    	@command_options = []
    	@utility = nil
    end

    def parse_input(input, output_as_file=true)
    	if input.is_a? String
    		return output_as_file ? File.new(input) : input
    	elsif input.is_a?(File) || input.is_a?(Tempfile)
    		return output_as_file ? input : input.path
    	else
    		raise TypeError, "You must specify a file as a String, File, or Tempfile object"
    	end
    end

	end
end