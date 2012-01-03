FROMAGE
=======

Add role to mongoid model with ease.

Installation
------------

Ruby 1.9.2 is required.

Install it with rubygems:

    gem install fromage

With bundler, add it to your `Gemfile`:

``` ruby
gem "fromage", "~>0.0.2"
```

Usage
-----

Two steps are required. Include `Mongoid::Fromage`, and defines roles with `fromage` method.

``` ruby
class Person
  include Mongoid::Document
  include Mongoid::Fromage

  fromages :time_lord, :companion
end
```

``` ruby
person.time_lord!                       # adds time_lord and save
person.time_lord?                       # check if person has time_lord role
person.un_time_lord!                    # remove time_lord from person and save
Person.any_role(:time_lord, :companion) # Return a criteria of persons having time_lord or companion role.
Person.all_role(:time_lord, :companion) # Return a criteria of persons having time_lord an companion role.
```

Note on Patches/Pull Requests
-----------------------------

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version unintentionally.
* Commit, do not mess with rakefile, version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself in another branch so I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.


Copyright
---------

MIT. See LICENSE for further details.

