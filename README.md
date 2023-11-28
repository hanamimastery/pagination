# Hanamimastery::Pagination

This is a pagination engine for Ruby applications powered up with algebraic effects implementation provided by [dry-effects](https://dry-rb.org/gems/dry-effects).

It allows to paginate any resource without passing pagination parameters down the stack as arguments.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add hanamimastery-pagination

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install hanamimastery-pagination

## Usage

### Calling the collection with pagination feature

Given you have a collection object, that stores the data fetching logic you would like to paginate:

```ruby
collection = MyCollection.new
```

You can call your collection with pagination parameters.

```ruby
# Allows you to call `paginate(params) { ... }`
include Hanamimastery::Pagination

pagination_params = { page: { size: 3, number: 2 } }
paginate(pagination_params) { collection.all } # => [4, 5, 6]

pagination_params = { page: { size: 2, number: 4 } }
paginate(pagination_params) { collection.all } # => [7, 8]
```

### Implementing the pagination in the collection

Your collection had been called with the pagination feature, so now you can access the
`pagination` object, in any place down the stack.

Here is how your collection fetching could look like:

```ruby
class MyCollection
  # Include the Hanamimastery::Pagination::Reader to have an access to the `pagination` object
  #
  include Hanamimastery::Pagination::Reader

  ITEMS = [1, 2, 3, 4, 5, 6, 7, 8, 9].freeze

  def all
    # Collection is called within the `paginate` block, so the `pagination` object
    #   is initialized with the provided pagination_params
    #
    offset = pagination.number - 1 # array indexing starts from 0 => 2
    limit = pagination.size # => 3
    array[offset, limit]
  rescue Hanamimastery::Pagination::PaginationUnsetError
    array
  end
end
```

### Calling collection without the `paginate` block

The collection tries to access the `pagination` object. In case this is not set (collection is called without `paginate(params)` block), it'll raise the `Hanamimastery::Pagination::PaginationUnsetError`.

You may want to rescue from it and implement the default behaviour as shown above.

## Examples

### Hanami 2 Example



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/hanamimastery-pagination. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/hanamimastery-pagination/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Hanamimastery::Pagination project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/hanamimastery-pagination/blob/master/CODE_OF_CONDUCT.md).
