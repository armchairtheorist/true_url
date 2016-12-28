class TrueURL
  class Context
    attr_reader :original_url, :options, :attributes, :working_url

    def initialize(original_url, options)
      @original_url = parse(original_url)
      @options = options
      @finalized = false
      @attributes = {}
      @base_url = parse(@options[:base_url]) unless @options[:base_url].nil?

      set_working_url(original_url)
    end

    def set_working_url(url)
      @working_url = @base_url.nil? ? parse(url) : @base_url.join(parse(url))
      @working_url.normalize

      # If the URL has a host but not scheme even after joining with the base URL, then we assume HTTP
      @working_url.scheme = 'http' if @working_url.scheme.nil? && @working_url.host
    end

    def finalize
      @finalized = true
    end

    def finalized?
      @finalized
    end

    private

    def parse(url)
      (url.is_a? Addressable::URI) ? url : Addressable::URI.parse(url)
    end
  end
end
