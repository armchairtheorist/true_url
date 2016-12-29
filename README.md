[![Gem Version](https://badge.fury.io/rb/true_url.svg)](https://badge.fury.io/rb/true_url)
[![Code Climate](https://codeclimate.com/github/armchairtheorist/true_url/badges/gpa.svg)](https://codeclimate.com/github/armchairtheorist/true_url)

# TrueURL

**TrueURL** helps normalize, clean and derive a canonical URL for any given URL. Unlike other similar projects, **TrueURL** uses a configurable multi-strategy approach, including tailored strategies for specific sites (e.g. YouTube, DailyMotion, Twitter, etc.) as well as general strategies (e.g. ```rel="canonical"```, etc.). 

## Installation

Install the gem from RubyGems:

```bash
gem install true_url
```

If you use Bundler, just add it to your Gemfile and run `bundle install`

```ruby
gem 'true_url'
```

I have only tested this gem on Ruby 2.3.0, but there shouldn't be any reason why it wouldn't work on earlier Ruby versions as well. **TrueURL** only requires the **Addressable** gem as a dependency. if page fetching is required, then the **HTTP** and **Nokogiri** gems are also required as dependencies. 

## Usage

```ruby
x = TrueURL.new("https://youtu.be/RDocnbkHjhI?list=PLs4hTtftqnlAkiQNdWn6bbKUr-P1wuSm0")
puts x.canonical # => https://www.youtube.com/watch?v=RDocnbkHjhI

x = TrueURL.new("http://embed.nicovideo.jp/watch/sm25956031/script?w=490&h=307&redirect=1")
puts x.canonical # => http://www.nicovideo.jp/watch/sm25956031

x = TrueURL.new("http://t.co/fvaGuRa5Za")
puts x.canonical # => http://www.prdaily.com/Main/Articles/3_essential_skills_for_todays_PR_pro__18404.aspx
```

## Other URL Canonicalization Projects (for Ruby)

* [URLCanonicalize](https://github.com/dominicsayers/url_canonicalize)
* [UrlParser](https://github.com/activefx/url_parser)
* [PostRank URI](https://github.com/postrank-labs/postrank-uri)
* [Linkr](https://github.com/bbc/linkr)
* [Pope](https://github.com/socksforrobots/pope)

## License
**TrueURL** is released under the [MIT license](MIT-LICENSE).
