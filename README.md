# EsEasyQuery

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/es_easy_query`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'es_easy_query'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install es_easy_query

## Usage

You must create one class per query, each of these class should have a query method containing
a valid elasticsearch query

Define your queries in ```app/es_queries```

Exemple

```
class SubjectSearchV1 < EsEasyQuery::Query::Base
  use_index :subject

  def query
    {
      query: {
        match_all: {
          text: params[:match]
        }
      }
    }
  end
end
```

This class will execute again the subject index.

The you can use anywhere in your code

```
EsEasyQuery.use(:subject_search_v1).search(match: "test")
```

It will return you your results



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/es_easy_query. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

