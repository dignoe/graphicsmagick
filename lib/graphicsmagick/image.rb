require 'tempfile'
require 'subexec'
require 'shellwords'
require 'graphicsmagick/utilities'

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

    # Returns the path of the associated file
    def path
      @file.path
    end

    # Writes the changes to the file specified in +output+.
    # Set +:timeout => 30.seconds+ to change the timeout value.
    # Default is one minute.
    def write(output, opts = {})
      output_path = parse_input(output, false)

      FileUtils.copy_file(path, output_path) unless requires_output_file?

      command = build_command(output_path)
      run(command, opts)
      GraphicsMagick::Image.new(output_path)
    end

    # Writes the changes to the current file.
    # Set +:timeout => 30.seconds+ to change the timeout value.
    # Default is one minute.
    def write!(opts = {})
      if requires_output_file?
        raise NoMethodError, "You cannot use Image#write(output) with "\
                             "the #{current_utility} command"
      end

      command = build_command(path)
      run(command, opts)
      self
    end

    protected

    def method_missing(method, *args, &block)
      add_option("-#{method.to_s.gsub(/_/, '-')}", *args)
    end

    private

    def add_option(option_name, *args)
      @command_options << {
        name: option_name,
        args: args.collect { |a| Shellwords.escape(a.to_s) }.join(' ')
      }
      self
    end

    def run(command, opts = {})
      opts = { timeout: 60 }.merge(opts)
      command = "gm #{command}"
      cmd = Subexec.run(command, opts)

      if cmd.exitstatus != 0
        raise UnknownOptionError, "#{command} failed: #{cmd.output}"
      end
    ensure
      @command_options = []
      @utility = nil
    end

    def parse_input(input, output_as_file = true)
      if input.is_a?(String)
        output_as_file ? File.new(input) : input
      elsif input.is_a?(File) || input.is_a?(Tempfile)
        output_as_file ? input : input.path
      else
        raise TypeError,
              'You must specify a file as a String, File, or Tempfile object'
      end
    end
  end
end
