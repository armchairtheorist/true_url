class TrueURL
	class Context
		attr_reader :original_url, :options
		attr_accessor :working_url

		def initialize (original_url, options)
			@original_url = original_url
			@options = options
			@finalized = false

			parse_new_url(original_url)
		end

		def parse_new_url (url)
			@working_url = parse(@options[:base_url]).join(parse(url))
			@working_url.normalize
		end

		def finalize
			@finalized = true
		end

		def finalized?
			return @finalized
		end

		private

		def parse (url)
			return (url.is_a? Addressable::URI) ? url : Addressable::URI.parse(url)
		end
	end
end
