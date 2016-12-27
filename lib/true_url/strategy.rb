require "true_url/strategy/default"
require "true_url/strategy/youtube"

class TrueURL
	module Strategy
		INDEX = {
			"youtube.com" => TrueURL::Strategy::YouTube.new,
			"youtube-nocookie.com" => TrueURL::Strategy::YouTube.new,
			"youtu.be" => TrueURL::Strategy::YouTube.new
		}.freeze

		def self.find (context)
	    	host = context.working_url.normalized_host
	    	INDEX.keys.each { |k| return INDEX[k] if host.end_with?(k) unless host.nil? }
	    	return TrueURL::Strategy::Default.new
    	end
	end
end