require 'addressable/uri'

class TrueURL
    autoload :Version, "true_url/version"
    autoload :Context, "true_url/context"
    autoload :Strategy, "true_url/strategy"
    
    attr_accessor :context

	OPTIONS = {
    	:default_scheme => "https" # Possible choices: "https", "http", nil (preserve scheme)
    }.freeze
    
    def initialize (url, options = {})
    	@context = TrueURL::Context.new(url, OPTIONS.merge(options))
    end

    def canonical
		while true do
            @context.retry_strategy = false
			TrueURL::Strategy.find(@context).find_canonical(@context)
			break unless @context.retry_strategy?
		end

    	set_scheme

    	return @context.working_url.to_s
    end

    private
    
    def set_scheme
    	@context.working_url.scheme = @context.options[:default_scheme] unless @context.options[:default_scheme].nil?
    end
end