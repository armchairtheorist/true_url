class TrueURL
  class Context
    attr_reader :original_url, :options, :attributes, :working_url

    def initialize(original_url, options)
      @original_url = parse(original_url)
      @options = options
      @finalized = false
      @attributes = {}

      set_working_url(original_url)
    end

    def set_working_url(url)
      @working_url = parse(url)

      # If the URL has no scheme, then we assume HTTP
      if @working_url.scheme.nil?
        @working_url = url.to_s.start_with?('//') ? parse("http:#{url.to_s}") : parse("http://#{url.to_s}") 
      end

      @working_url.normalize
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
