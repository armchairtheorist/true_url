class TrueURL
  module Strategy
    class YouTube
      def execute(context)
        path = context.working_url.path

        if context.working_url.host == 'youtu.be'
          video_id = path[1..-1]

        elsif path == '/watch'
          video_id = context.working_url.query_values['v']

        elsif path == '/playlist'
          playlist_id = context.working_url.query_values['list']

        elsif path[0..17] == '/embed/videoseries'
          playlist_id = context.working_url.query_values['list']

        elsif path[0..6] == '/embed/'
          video_id = path[7..-1]
        end

        unless video_id.nil?
          context.set_working_url("https://www.youtube.com/watch?v=#{video_id}")
          context.finalize
          context.attributes[:embed_url] = "https://www.youtube.com/embed/#{video_id}"
          context.attributes[:embed_url_private] = "https://www.youtube-nocookie.com/embed/#{video_id}"
        end

        unless playlist_id.nil?
          context.set_working_url("https://www.youtube.com/playlist?list=#{playlist_id}")
          context.finalize
          context.attributes[:embed_url] = "https://www.youtube.com/embed/videoseries?list=#{playlist_id}"
          context.attributes[:embed_url_private] = "https://www.youtube-nocookie.com/embed/videoseries?list=#{playlist_id}"
        end
      end
    end
  end
end
