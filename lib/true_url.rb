require 'addressable/uri'

class TrueURL
    autoload :Version, "true_url/version"
    autoload :Context, "true_url/context"
    autoload :Strategy, "true_url/strategy"
    
    attr_accessor :context

	OPTIONS = {
    	:default_scheme => "https",    # Possible choices: "https", "http", nil (preserve scheme)
        :base_url => ""                # Can accept either a String or an Addressable::URI object 
    }.freeze
    
    def initialize (url, options = {})
    	@context = TrueURL::Context.new(url, OPTIONS.merge(options))
    end

    def canonical
        TrueURL::Strategy.run(@context)
    	set_scheme

    	return @context.working_url.to_s
    end

    private
    
    def set_scheme
    	@context.working_url.scheme = @context.options[:default_scheme] unless @context.options[:default_scheme].nil?
    end
end