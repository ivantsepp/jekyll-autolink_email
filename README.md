# Jekyll::AutolinkEmail

Autolink emails for your Jekyll Site.

## Installation

Add to your `Gemfile`:

```
gem 'jekyll-autolink_email'
```

Add to your `_config.yml`:

```yml
gems:
  - jekyll-autolink_email
```

## Usage

In any html page or post, emails will be autolinked. So if you write `foo@example.com`, the resulting html will be `<a href="mailto:foo@example.com">foo@example.com</a>`

## Configuration

Autolinking is done by [Rinku](https://github.com/vmg/rinku) so visit that gem for a more in-depth explanation of the configuration options:

```yml
autolink_email:
  link_attr: class='email-link' # attributes to add to the link
  skip_tags: ['div']            # tags to skip
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/jekyll-autolink/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
