require 'http'
require 'nokogiri'

class TrueURL
  module Fetch
    extend self
    
    def execute(context)
      starting_url = context.working_url

      response = HTTP.follow
                     .get(starting_url)

      canonical_url = find_canonical_header(response.headers) || find_canonical_url(response.to_s) || response.uri
      context.set_working_url(canonical_url, starting_url)
    end

    def find_canonical_header(headers)
      return if headers['Link'].nil?

      links = headers['Link'].is_a?(String) ? [headers['Link']] : headers['Link']
      links.each { |link| return link.split(/[<>;]/)[1] if link.end_with?('rel="canonical"') }
      nil
    end

    def find_canonical_url(html)
      doc = Nokogiri::HTML(html)

      elem = doc.at('link[rel="canonical"]')
      canonical_url = elem['href'] unless elem.nil?

      elem = doc.at('meta[property="og:url"]')
      og_url = elem['content'] unless elem.nil?

      canonical_url || og_url
    end
  end
end
