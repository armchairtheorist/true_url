require 'true_url/strategy/youtube'

class TrueURL
  module Strategy
    def self.default_list
      [
        ['youtube.com', TrueURL::Strategy::YouTube.new],
        ['youtube-nocookie.com', TrueURL::Strategy::YouTube.new],
        ['youtu.be', TrueURL::Strategy::YouTube.new]
      ]
    end
  end
end
