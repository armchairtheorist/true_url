class TrueURL
	class Context
		attr_accessor :url, :options, :working_url, :retry_strategy

		def initialize (url, options)
			@url = url
			@options = options
			@working_url = Addressable::URI.parse(url)
			@canonical_found = false
		end

		def retry_strategy?
			return @retry_strategy
		end
	end
end
