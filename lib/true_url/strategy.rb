require "true_url/strategy/default"
require "true_url/strategy/youtube"

class TrueURL
	module Strategy
		INDEX = {
			"youtube.com" => TrueURL::Strategy::YouTube.new,
			"youtube-nocookie.com" => TrueURL::Strategy::YouTube.new,
			"youtu.be" => TrueURL::Strategy::YouTube.new,
			:default => TrueURL::Strategy::Default.new
		}.freeze


		def self.run (context)
			INDEX.keys.each do |k|
				INDEX[k].find_canonical(context) if strategy_match?(context, k) unless context.finalized?
			end
		end

		def self.strategy_match? (context, strategy_key)
			return true if strategy_key == :default

			host = context.working_url.host
			return host.nil? ? false : host.end_with?(strategy_key)
		end
	end
end