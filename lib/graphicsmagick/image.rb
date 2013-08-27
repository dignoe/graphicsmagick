require 'tempfile'
require 'subexec'
require 'shellwords'
require 'graphicsmagick/utilities'
require 'active_support/core_ext/numeric/time'

module GraphicsMagick

	GraphicsMagickError = Class.new(StandardError)

	class Image
		attr_reader :file

		include GraphicsMagick::Utilities

    def initialize(input)
    	@command_options = []
    	@utility = nil

    	self.file = parse_input(input)
  	end

  	def path
  		file.path
  	end

  	def write output
  		output_path = parse_input(output, false)

  		if @utility.nil?
  			@utility = "mogrify"
  			FileUtils.copy_file(path, output_path)
  		end
  		command = self.send(:"build_#{@utility}_command", output_path)

  		run(command)
  		GraphicsMagick::Image.new(output_path)
  	end

  	def write!
  		if @utility.nil?
  			@utility = "mogrify"
  		else
  			raise NoMethodError, "You must use Image#write(output) with the #{utility} command"
  		end

  		command = self.send(:"build_#{@utility}_command", path)

  		run(command)
  		self
  	end

  	protected

  	def method_missing(method, *args, &block)
      add_option("-#{method.to_s.gsub(/_/,'-')}", *args)
    end

    private

    def add_option option_name, *args
    	command_options << {:name => option_name, :args => args.collect { |a| Shellwords.escape(a.to_s) }.join(" ")}
    	self
    end

    def run command
    	command = "gm #{command}"
    	cmd = Subexec.run(command, :timeout => 30.seconds)

      if cmd.exitstatus != 0
      	raise GraphicsMagickError, "#{command} failed: #{cmd.output}"
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