# FROMAGE

Add roles to mongoid's model with ease.

## Installation

Ruby 1.9.2 is required.

Install it with rubygems:

    gem install fromage

With bundler, add it to your `Gemfile`:

``` ruby
gem "fromage", require: 'mongoid/fromage'
```

## Usage

Two steps are required. Include `Mongoid::Fromage`, and defines roles with
`fromage` method.

``` ruby
class Person
  include Mongoid::Document
  include Mongoid::Fromage

  fromages :time_lord, :companion, defaults: [:time_lord]
end
```

``` ruby
# adds time_lord and save
person.time_lord!
# check if person has time_lord role
person.time_lord?
# remove time_lord from person and save
person.un_time_lord!
# Return a criteria of persons having time_lord or companion role.
Person.any_role(:time_lord, :companion)
# Return a criteria of persons having time_lord an companion role.
Person.all_role(:time_lord, :companion)
```

## Contrib

You will find `simple_form` roles input example in `contrib` directory.

## Copyright

MIT. See LICENSE for further details.
