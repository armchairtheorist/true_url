class TrueURL
  module Strategy
    class NicoVideo
      def execute(context)
        path = context.working_url.path

        if path[0..6] == '/watch/'
          video_id = path.split('/')[2]
        
        elsif path[0..12] == '/thumb_watch/'
          video_id = path.split('/')[2]
        end

        if video_id
          context.set_working_url("http://www.nicovideo.jp/watch/#{video_id}")
          context.finalize
          context.attributes[:embed_url] = "http://embed.nicovideo.jp/watch/#{video_id}"
        end

        # Nico Video only supports HTTP
        context.working_url.scheme = "http"
      end
    end
  end
end
