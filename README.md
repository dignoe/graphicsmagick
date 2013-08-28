# Graphicsmagick

A very light Ruby wrapper for the Graphicsmagick CLI that supports mogrify, composite, and convert, plus a few convenience methods.

## Why?

Graphicsmagick was 10x faster for our image processing needs than ImageMagick.
I wanted to use Graphicsmagick, but wanted a Ruby wrapper to help deal with exceptions and long running tasks. I needed to use multiple utilities within Graphicsmagick and the current crop of *_magick gems either did not support all of them, or had costly overhead (or both).

## Installation

#### Install Graphicsmagick
http://www.graphicsmagick.org/README.html

On OS X, it's recommended to use `brew`
```bash
brew update
brew install graphicsmagick
```

#### Install gem
Add this line to your application's Gemfile:

    gem 'graphicsmagick'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install graphicsmagick

## Usage

#### Mogrify commands and overwriting file
```ruby
img = GraphicsMagick::Image.new('my_file.jpg')
img.crop('360x504+432+72').resize('125x177!')
img.write!
```
Equivalent to
```bash
gm mogrify -crop '360x504+432+72' -resize '125x177!' my_file.jpg
```


#### Mogrify commands and write to new file
```ruby
img = GraphicsMagick::Image.new('my_file.jpg')
img.crop('360x504+432+72').resize('125x177!')
img.write('my_new_file.jpg')
```
Equivalent to
```bash
cp my_file.jpg my_new_file.jpg & gm mogrify -crop '360x504+432+72' -resize '125x177!' my_new_file.jpg
```


#### Convert a PDF file to a PNG while passing options at both steps
```ruby
img = GraphicsMagick::Image.new("my_file.pdf")
img.strip.density(144).colorspace('RGB').auto-orient
img.convert.resize('50%')
img.write('my_new_file.png')
```
Equivalent to
```bash
gm convert -density 144 -strip -colorspace RGB -auto-orient "my_file.pdf" -resize '50%' my_new_file.png
```


#### Composite an image over another image
```ruby
background = GraphicsMagick::Image.new("background.png")
img = GraphicsMagick::Image.new("overlay.png")
img.composite(background).geometry('+100+150')
img.write('composite.png')
```
Equivalent to
```bash
gm composite -geometry +100+150 background.png overlay.png composite.png
```


#### You can pass a file too
```ruby
file = File.new('my_file.png')
img = GraphicsMagick::Image.new(file)

temp_img = GraphicsMagick::Image.new(Tempfile.new('foo'))
temp_img.path  #=> "path/to/temp/file"
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
