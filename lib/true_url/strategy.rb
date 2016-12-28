require 'true_url/strategy/dailymotion'
require 'true_url/strategy/nicovideo'
require 'true_url/strategy/vimeo'
require 'true_url/strategy/youtube'

class TrueURL
  module Strategy
    def self.default_list
      [
        ['youtube.com', TrueURL::Strategy::YouTube.new],
        ['youtube-nocookie.com', TrueURL::Strategy::YouTube.new],
        ['youtu.be', TrueURL::Strategy::YouTube.new],
        ['dailymotion.com', TrueURL::Strategy::DailyMotion.new],
        ['dai.ly', TrueURL::Strategy::DailyMotion.new],
        ['vimeo.com', TrueURL::Strategy::Vimeo.new],
        ['nicovideo.jp', TrueURL::Strategy::NicoVideo.new],
        ['nico.ms', TrueURL::Strategy::NicoVideo.new]
      ]
    end
  end
end
