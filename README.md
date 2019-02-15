# Consimilo

[![Build Status: master](https://travis-ci.com/XPBytes/consimilo.svg)](https://travis-ci.com/XPBytes/consimilo)
[![Gem Version](https://badge.fury.io/rb/consimilo.svg)](https://badge.fury.io/rb/consimilo)
[![MIT license](http://img.shields.io/badge/license-MIT-brightgreen.svg)](http://opensource.org/licenses/MIT)

:nut_and_bolt: Compare (consimilo) primitives such as Hash and Array deeply

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'consimilo'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install consimilo

## Usage

When you're comparing two states, two data sets or something similar, you might to know _what_ has changed.
Running the two versions through `Consimilo` gives a snapshot of the difference between the two, with each
difference represented as a pair `[from, to]`. 

```ruby
require 'consimilo'

before = [1, 2 ,3]
after = [3, 2, 1]
Consimilo.difference(before, after)
# => [[1, 3], [], [3,1]]

before = { foo: [:a, :b], bar: 1, same: 0 }
after = { foo: [:a, :c], next: 3, same: 0 }
Consimilo.difference(before, after)
# => { foo: [[], [:b, :c]], bar: [1, nil], next: [nil, 3] }
```

By default, `Consimilo` enforces `Array` order. This can be turned off with the `order` option:

```ruby
before = [1, 2 ,3]
after = [3, 2, 1]
Consimilo.difference(before, after, order: false)
# => []
```

By default `Consimilo` returns empty "differences" for arrays, unless the entire array is equal, so that 
you may trace back at which index something has changed. This can be turned off by setting the `compact` option:

```ruby
before = [1, 2 ,3]
after = [3, 2, 1]
Consimilo.difference(before, after, compact: true)
# => [[1, 3], [3,1]]
```

You can also require `'consimilo/kernel'` in your code or Gemfile in order to enable an additional `Kernel`
method `Consimilo(left, right, order: true, compact: false)`:

```ruby
require 'consimilo/kernel'

before = [1, 2 ,3]
after = [3, 2, 1]
Consimilo(before, after, compact: true)
# => [[1, 3], [3,1]]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can
also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the
version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version,
push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at [XPBytes/consimilo](https://github.com/XPBytes/consimilo).
