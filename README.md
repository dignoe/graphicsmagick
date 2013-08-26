# Graphicsmagick

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'graphicsmagick'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install graphicsmagick

## Usage

```ruby
img = GraphicsMagick::Image.new('my_file.jpg')
img.crop(360,504,432,72).resize('125x177!')
img.write! # img.write('my_new_file2.jpg')
```

```ruby
img = GraphicsMagick::Image.new("my_file.pdf")
img.strip.density(144).colorspace('RGB').auto-orient
img.convert.resize('50%')
img.write('my_new_file.png')
```

```ruby
background = GraphicsMagick::Image.new("background.png")
img = GraphicsMagick::Image.new("overlay.png")
img.composite(background).geometry('+100+150')
img.write('composite.png')

```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
