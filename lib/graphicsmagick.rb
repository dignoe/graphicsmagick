module GraphicsMagick
  # Your code goes here...
end

raise StandardError, "Please install GraphicsMagick" unless system("hash gm 2>&-")

require "graphicsmagick/version"
require "graphicsmagick/image"