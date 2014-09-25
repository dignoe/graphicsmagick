require 'mkmf'

module GraphicsMagick
  
end

# raise StandardError, "Please install GraphicsMagick" unless system("hash gm 2>&-")
raise StandardError, "Please install GraphicsMagick" unless find_executable('gm')

require "graphicsmagick/version"
require "graphicsmagick/image"
