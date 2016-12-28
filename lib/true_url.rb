require 'addressable/uri'
require 'http'
require 'nokogiri'

class TrueURL
  autoload :Version, 'true_url/version'
  autoload :Context, 'true_url/context'
  autoload :Strategy, 'true_url/strategy'

  attr_accessor :context, :strategies

  OPTIONS = {
    scheme_override: nil, # Possible choices: "https", "http", nil (preserve scheme)
    fetch: true # Whether to fetch the URL
  }.freeze

  QUERY_VALUES_TO_REMOVE = %w(
    utm_source
    utm_medium
    utm_term
    utm_content
    utm_campaign
    sms_ss
    awesm
    xtor
    PHPSESSID
  ).freeze

  def initialize(url, options = {})
    @context = TrueURL::Context.new(url, OPTIONS.merge(options))
    @strategies = TrueURL::Strategy.default_list
    @executed = false
  end

  def canonical
    execute
    @context.working_url.to_s
  end

  def attributes
    execute
    @context.attributes
  end

  private

  def execute
    return if @executed

    execute_strategies

    unless @context.finalized?
      if attempt_fetch?
        fetch
        execute_strategies
      end
    end

    scheme_override
    remove_fragments
    clean_query_values

    @executed = true
  end

  def execute_strategies
    @strategies.each do |s|
      match_criteria = s[0]
      strategy = s[1]

      strategy.execute(@context) unless @context.finalized? || !strategy_match?(match_criteria)
    end
  end

  def strategy_match?(match_criteria)
    return true if match_criteria.nil?

    host = @context.working_url.host
    host.nil? ? false : host.match(match_criteria)
  end

  def attempt_fetch?
    return false unless @context.options[:fetch]

    # Must at least have a host, otherwise we can't find the site to crawl
    return false if @context.working_url.host.nil?

    # We only support HTTP or HTTPS
    %w(http https).include?(@context.working_url.scheme)
  end

  def fetch
    starting_url = @context.working_url

    response = HTTP.follow
                   .get(starting_url)

    canonical_url = find_canonical_header(response.headers) || find_canonical_url(response.to_s) || response.uri
    @context.set_working_url(canonical_url, starting_url)
  end

  def find_canonical_header(headers)
    return if headers['Link'].nil?

    links = (headers['Link'].is_a? String) ? [headers['Link']] : headers['Link']
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

  def scheme_override
    @context.working_url.scheme = @context.options[:scheme_override] unless @context.options[:scheme_override].nil?
  end

  def remove_fragments
    @context.working_url.fragment = nil
  end

  def clean_query_values
    query_values = @context.working_url.query_values

    unless query_values.nil?
      QUERY_VALUES_TO_REMOVE.each { |p| query_values.delete(p) }
      @context.working_url.query_values = query_values.empty? ? nil : query_values
    end
  end
end
